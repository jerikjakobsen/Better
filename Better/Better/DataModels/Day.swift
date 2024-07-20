//
//  Day.swift
//  Better
//
//  Created by John Jakobsen on 4/12/24.
//

import Foundation

struct Day {
    let name: String
    let id: String
    let completed: Bool
    
    func with(name: String? = nil, id: String? = nil, completed: Bool? = nil) -> Day {
        return Day(name: name ?? self.name, id: id ?? self.id, completed: completed ?? self.completed)
    }
}
