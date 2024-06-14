//
//  ExerciseSession.swift
//  Better
//
//  Created by John Jakobsen on 5/7/24.
//

import Foundation

enum ExerciseSessionError: Error {
    case SessionAlreadyActive
    case NoSessionActive
}

class ExerciseSession {
    
    var id: String? = nil
    let exercise: Exercise
    let startTime: Date
    var averageBreak: TimeInterval? = nil
    var duration: TimeInterval? {
        if let notNilEndTime = self.endTime {
            return notNilEndTime.timeIntervalSince(startTime)
        }
        return nil
    }
    var averageWeight: Float {
        return setSessions.map { sess in
            return sess.weight
        }.average()
    }
    var averageReps: Float {
        return setSessions.map { sess in
            return sess.reps
        }.average()
    }
    var notes: String? = nil
    var endTime: Date? = nil
    var setSessions: [SetSession] = []
    
    //static var current_exercise_session: ExerciseSession? = nil
    
    init(startTime: Date, exercise: Exercise) {
        self.startTime = startTime
        self.exercise = exercise
    }
    
    static func startExerciseSession(exercise: Exercise) -> ExerciseSession {
        return ExerciseSession(startTime: Date.now, exercise: exercise)
    }
    
    func endExerciseSession() {
        self.endTime = Date.now
    }
    
    
}
