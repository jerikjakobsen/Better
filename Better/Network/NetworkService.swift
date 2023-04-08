//
//  NetworkService.swift
//  Better
//
//  Created by John Jakobsen on 4/8/23.
//

import Foundation
import Combine

class NetworkService {
    struct NetworkResponse {
        let code: Int?
        let data: [String: Any]?
        let error: String?
    }
    
    enum RequestType {
        case GET
        case POST
    }
    
    enum NetworkServiceError: Error {
        case ConvertURLStringtoURL
        case ConvertBodyToJSON
        case ConvertResponse
        case ConvertJSONToDict
    }
    static let shared = NetworkService()
    
    private init() {}
    
    func request(requestType: RequestType, urlString: String, body: [String: Any]? = nil, parameters: [String: String]? = nil) async throws -> NetworkResponse  {
        var url: URL
        if (parameters == nil) {
            guard let newURL = URL(string: urlString) else {
                throw NetworkServiceError.ConvertURLStringtoURL
            }
            url = newURL
        } else {
            guard var urlComponents = URLComponents(string: urlString) else {
                    throw NetworkServiceError.ConvertURLStringtoURL
                }

            urlComponents.queryItems = parameters?.map({ (key: String, value: String) in
                return URLQueryItem(name: key, value: value)
            })

            guard let newURL = urlComponents.url else {
                throw NetworkServiceError.ConvertURLStringtoURL
            }
            url = newURL
        }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        switch requestType {
        case .GET:
            request.httpMethod = "GET"
            break
        case .POST:
            request.httpMethod = "POST"
            break
        }
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        if (body != nil) {
            guard let jsonData = try? JSONSerialization.data(withJSONObject: body!, options: []) else {
                throw NetworkServiceError.ConvertBodyToJSON
                }
            request.httpBody = jsonData
        }
        
        let (data, response) = try await URLSession.shared.data(for: request)
        guard let httpResponse = response as? HTTPURLResponse else {
            throw NetworkServiceError.ConvertResponse
            }
        guard let parsedJSONData = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] else {
            throw NetworkServiceError.ConvertJSONToDict
        }
        if httpResponse.statusCode >= 300 {
            return NetworkResponse(code: httpResponse.statusCode, data: nil, error: parsedJSONData["error"] as? String ?? "")
        }
        return NetworkResponse(code: httpResponse.statusCode, data: parsedJSONData, error: nil)
    }
    
}
