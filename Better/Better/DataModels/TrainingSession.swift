//
//  TrainingSession.swift
//  Better
//
//  Created by John Jakobsen on 5/6/24.
//

import Foundation

enum TrainingSessionError: Error {
    case SessionAlreadyActive
    case NoSessionActive
}

class TrainingSession {

    var id: String? = nil
    let startTime: Date
    var endTime: Date? = nil
    var routine: Routine
    let day: Day
    let routine_number: Int
    var exercise_sessions: [ExerciseSession] = []
    
    static var current_training_session: TrainingSession? = nil
    
    init(startTime: Date, routine: Routine, day: Day, routine_number: Int) {
        self.startTime = startTime
        self.routine = routine
        self.day = day
        self.routine_number = routine_number
    }
    
    static func startCurrentTrainingSession(routine: Routine, day: Day) throws  {
        guard TrainingSession.current_training_session == nil else {
            throw TrainingSessionError.SessionAlreadyActive
        }
        TrainingSession.current_training_session = TrainingSession(startTime: Date.now, routine: routine, day: day, routine_number: routine.current_routine_number)
    }
    
    static func endCurrentTrainingSession() throws -> TrainingSession? {
        guard let currTraining = TrainingSession.current_training_session else {
            throw TrainingSessionError.NoSessionActive
        }
        
        TrainingSession.current_training_session = nil
        currTraining.routine.current_routine_number += 1
        
        return currTraining
    }
}
