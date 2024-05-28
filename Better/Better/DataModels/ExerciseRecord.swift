//
//  ExerciseRecord.swift
//  Better
//
//  Created by John Jakobsen on 5/8/24.
//

import Foundation

class ExerciseRecord {

    let weight: [Float]
    let reps: [Int]
    let date: Date
    let duration: TimeInterval
    var notes: String? = nil
    
    init(weight: [Float], reps: [Int], date: Date, duration: TimeInterval, notes: String? = nil) {
        self.weight = weight
        self.reps = reps
        self.date = date
        self.duration = duration
        self.notes = notes
    }
    
}
