//
//  Routine.swift
//  Better
//
//  Created by John Jakobsen on 4/6/23.
//

import Foundation

class Routine: NSObject, NSCopying {
    func copy(with zone: NSZone? = nil) -> Any {
        return Routine(name: name, exercises: exercises, id: id)
    }
    
    var id: String?
    var name: String?
    var exercises: [String: [Exercise]]?
    
    init(name: String? = nil, exercises: [String: [Exercise]]? = nil, id: String? = nil) {
        self.id = id
        self.name = name
        self.exercises = exercises
    }
    
    init(json: [String: Any]) {
        name = json["routine_name"] as? String
        id = json["routine_id"] as? String
        self.exercises = [:]
        let jsonSessions = (json["exercises"] as? [[String: Any]]) ?? []
        
        for jsonSession in jsonSessions {
            guard let sessionName = jsonSession["session_title"] as? String else {return}
            guard let jsonSessionExercises = jsonSession["session_exercises"] as? [[String: Any]] else {return}
            let sessionExercises = jsonSessionExercises.map({ jsonExercise in
                return Exercise(dict: jsonExercise)
            })
            self.exercises?[sessionName] = sessionExercises
        }
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
                return e.isEqual(e: exercise)
            })
        }
    }
    
    func moveExercise(from: String, to: String, exercise: Exercise) {
        self.removeExercise(exercise: exercise, session_title: from)
        self.addExercise(exercise: exercise, session_title: to)
    }
    
    // Update by sending list of updated exercises
    
    // Save Routine
    
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
    
   
    
    func toJSON() -> [String: Any] {
        guard let keys = self.exercises?.keys else {return ["routine_name": self.name ?? "", "exercises": [] as [[String: Any]]]}
        var json: [String: Any?] = [:]
        json["routine_name"] = self.name ?? ""
        json["routine_id"] = self.id ?? ""
        var exercisesArray: [[String: Any]] = []
        for session_title in keys {
            let exercises = self.exercises?[session_title] as? [Exercise]
            let jsonExercises = exercises?.compactMap({ exercise in
                return exercise.id
            })
            let jsonSession: [String : Any] = ["session_title": session_title, "session_exercises": jsonExercises ?? [] as [String]]
            exercisesArray.append(jsonSession)
        }
        json["exercises"] = exercisesArray
    }
    
    
    // Set Default Routine
    
    
}
