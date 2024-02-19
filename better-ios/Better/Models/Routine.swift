//
//  Routine.swift
//  Better
//
//  Created by John Jakobsen on 4/6/23.
//

import Foundation

class Routine: NSObject{
    var id: String?
    var name: String?
    var exercises: [[Exercise]]?
    var namesToSessions: [String]?
    
    init(name: String? = nil, exercises: [[Exercise]]? = nil, namesToSessions: [String]? = nil, id: String? = nil) {
        self.id = id
        self.name = name
        self.exercises = exercises
        self.namesToSessions = namesToSessions
    }
    
    init(json: [String: Any]) {
        name = json["routine_name"] as? String
        id = json["routine_id"] as? String
        self.exercises = []
        self.namesToSessions = []
        let jsonSessions = (json["exercises"] as? [[String: Any]]) ?? []
        
        for jsonSession in jsonSessions {
            guard let sessionName = jsonSession["session_title"] as? String else {return}
            namesToSessions?.append(sessionName)
            guard let jsonSessionExercises = jsonSession["session_exercises"] as? [[String: Any]] else {return}
            let sessionExercises = jsonSessionExercises.map({ jsonExercise in
                return Exercise(dict: jsonExercise)
            })
            self.exercises?.append(sessionExercises)
        }
    }
    
    func addExercise(exercise: Exercise, indexPath: IndexPath) {
        if (exercises == nil) {
            self.exercises = []
            self.namesToSessions = []
        }
        
        if (indexPath.section >= self.exercises?.count ?? 0) {
            return
        }
        if (indexPath.row >= self.exercises?[indexPath.section].count ?? 0) {
            self.exercises?[indexPath.section].append(exercise)
        } else {
            self.exercises?[indexPath.section].insert(exercise, at: indexPath.row)
        }
    }
    
    func removeExercise(indexPath: IndexPath) {
        if (self.exercises == nil) {return}
        
        if (indexPath.section >= self.exercises?.count ?? 0 || indexPath.row >= self.exercises?[indexPath.section].count ?? 0) {
            return
        }
        
        self.exercises?[indexPath.section].remove(at: indexPath.row)
    }
    
    func moveExercise(from: IndexPath, to: IndexPath) {
        
        guard let exercise = self.exercises?[from.section][from.row] else {
            return
        }
        self.removeExercise(indexPath: from)
        self.addExercise(exercise: exercise, indexPath: to)
    }
    
    func addSession(title: String, indexPath: IndexPath) {
        self.exercises?.insert([], at: indexPath.section)
        self.namesToSessions?.insert(title, at: indexPath.row)
    }
    
    func removeSession(indexPath: IndexPath) {
        self.exercises?.remove(at: indexPath.section)
        self.exercises?.remove(at: indexPath.section)
    }
    
    func moveSection(from: IndexPath, to: IndexPath) {
        guard let tempExercises = self.exercises?[from.section] else {return}
        guard let tempName = self.namesToSessions?[from.section] else {return}
        self.removeSession(indexPath: from)
        self.addSession(title: tempName, indexPath: to)
        self.exercises?[to.section] = tempExercises
    }
    
    func exerciseForRowAt(indexPath: IndexPath) -> Exercise? {
        return self.exercises?[indexPath.section][indexPath.row]
    }
    func sectionTitleForSection(section: Int) -> String? {
        return self.namesToSessions?[section]
    }
    
    func exerciseCountForSection(section: Int) -> Int {
        return self.exercises?[section].count ?? 0
    }
    
    func sessionCount() -> Int {
        return self.exercises?.count ?? 0
    }
        
    func saveRoutine() async {
        let route = id == nil ? "createRoutine" : "updateRoutine"
        do {
            let response = try await NetworkService.shared.request(requestType: .POST, urlString: "https://us-central1-better-73739.cloudfunctions.net/app/\(route)", body: self.toJSON())
            if (route == "updateRoutine") {
                self.id = response.data?["routine_id"] as? String
            }
        } catch {
            print("Could not save routine due to error: \(error)")
        }
        
    }
    
    static func fetchDefaultRoutine() async -> Routine? {
        do {
            let response = try await NetworkService.shared.request(requestType: .GET, urlString: "https://us-central1-better-73739.cloudfunctions.net/app/getDefaultRoutine")
            if (response.data != nil) {
                return Routine(json: response.data!)
            } else {
                return nil
            }
            
        } catch {
            print("Could not fetch default routine due to error: \(error)")
            return nil
        }
    }
    
    static func fetchAllRoutineNames() async -> [Routine]? {
        do {
            let response = try await NetworkService.shared.request(requestType: .GET, urlString: "https://us-central1-better-73739.cloudfunctions.net/app/getRoutineNamesIds")
            if let routinesJSON = response.data?["data"] as? [[String: Any]] {
                return routinesJSON.map { dict -> Routine in
                    let id = dict["routine_id"] as? String
                    let name = dict["routine_name"] as? String
                    return Routine(name: name ,id: id)
                }
            } else {
                return nil
            }
            
        } catch {
            print("Could not fetch default routine due to error: \(error)")
            return []
        }
    }
    
    func toJSON() -> [String: Any] {
        guard let sessions = self.exercises else {return ["routine_name": self.name ?? "", "exercises": [] as [[String: Any]]]}
        var json: [String: Any?] = [:]
        json["routine_name"] = self.name ?? ""
        json["routine_id"] = self.id ?? ""
        var exercisesArray: [[String: Any]] = []
        for (index, exercises) in sessions.enumerated() {
            let jsonExercises = exercises.compactMap({ exercise in
                return exercise.id
            })
            let jsonSession: [String : Any] = ["session_title": namesToSessions?[index] ?? "Day \(index)", "session_exercises": jsonExercises ]
            exercisesArray.append(jsonSession)
        }
        json["exercises"] = exercisesArray
        return json
    }
    
    
    func fetchExercises() async {
        do {
            let response = try await NetworkService.shared.request(requestType: .GET, urlString: "https://us-central1-better-73739.cloudfunctions.net/app/getRoutine", parameters: ["routine_id": self.id ?? ""])
            if let json = response.data {
                self.exercises = []
                let jsonSessions = (json["exercises"] as? [[String: Any]]) ?? []
                
                for jsonSession in jsonSessions {
                    guard let sessionName = jsonSession["session_title"] as? String else {return}
                    guard let jsonSessionExercises = jsonSession["session_exercises"] as? [[String: Any]] else {return}
                    let sessionExercises = jsonSessionExercises.map({ jsonExercise in
                        return Exercise(dict: jsonExercise)
                    })
                    self.exercises?.append(sessionExercises)
                    self.namesToSessions?.append(sessionName)
                }
            }
        } catch {
            print("Could not fetch default routine due to error: \(error)")
        }
    }
    
    
}
