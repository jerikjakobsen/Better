//
//  Exercise.swift
//  Better
//
//  Created by John Jakobsen on 4/16/24.
//

import Foundation

struct Exercise {
    let name: String
    let id: String
    let muscleGroups: [MuscleGroup]
    let routine_exercise_id: String?
    let timeToComplete: TimeInterval?
    let reps: [Int]?
    let weight: [Int]?
    let averageBreak: TimeInterval?
    
    init(name: String, id: String, muscleGroups: [MuscleGroup], routine_exercise_id: String? = nil, timeToComplete: TimeInterval? = nil, reps: [Int]? = nil, weight: [Int]? = nil, averageBreak: TimeInterval? = nil) {
        self.name = name
        self.id = id
        self.muscleGroups = muscleGroups
        self.routine_exercise_id = routine_exercise_id
        self.timeToComplete = timeToComplete
        self.reps = reps
        self.weight = weight
        self.averageBreak = averageBreak
    }
}
