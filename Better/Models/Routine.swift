//
//  Routine.swift
//  Better
//
//  Created by John Jakobsen on 4/6/23.
//

import Foundation

class Routine {
    let id: String?
    let name: String?
    var exercises: [String: [Exercise]]?
    
    init(id: String, name: String, exercises: [String: [Exercise]]?) {
        self.id = id
        self.name = name
        self.exercises = exercises
    }
    
    func addExercise(exercise: Exercise, session_title: String) {
        if (exercises == nil) {
            self.exercises = [:]
        }
        
        if (self.exercises?.keys.contains(session_title) ?? false) {
            self.exercises?[session_title]?.append(exercise)
        } else {
            self.exercises?[session_title] = []
            self.exercises?[session_title]?.append(exercise)
        }
    }
    
    func removeExercise(exercise: Exercise, session_title: String) {
        if (self.exercises == nil) {return}
        
        if (!(self.exercises?.keys.contains(session_title) ?? false)) {
            return
        } else {
            self.exercises?[session_title]?.removeAll(where: { e in
                if 
            })
        }
    }
    
    // Update by sending list of updated exercises
    
    // Save Routine
    
    
    
    // Set Default Routine
    
    
}
