//
//  SetSession.swift
//  Better
//
//  Created by John Jakobsen on 5/7/24.
//

import Foundation

class SetSession {
    
    var id: String? = nil
    let startTime: Date
    let endTime: Date
    let weight: Float
    let reps: Int
    var duration: TimeInterval {
        return endTime.timeIntervalSince(startTime)
    }
    
    init(startTime: Date, endTime: Date, weight: Float, reps: Int) {
        self.startTime = startTime
        self.endTime = endTime
        self.weight = weight
        self.reps = reps
    }
}
