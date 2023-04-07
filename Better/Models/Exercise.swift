//
//  Exercise.swift
//  Better
//
//  Created by John Jakobsen on 2/10/23.
//

import Foundation
import FirebaseFirestore

class Exercise {
    let name: String?
    var type: [MuscleGroup?]
    var weight: Float?
    var reps: String?
    let link: String?
    var id: String?
    let description: String?
    init(dict: [String: Any?]) {
        name = dict["name"] as? String
        type = []
        if let t = dict["type"] as? [String] {
            for s in t {
                type.append(MuscleGroup(rawValue: s))
            }
        }
        weight = dict["weight"] as? Float
        reps = dict["reps"] as? String
        link = dict["link"] as? String
        id = dict["id"] as? String
        description = dict["description"] as? String
        if let id = dict["documentID"] {
            self.id = id as? String
        }
    }
    
    init(name: String, type: [String], weight: Float, reps: String, link: String, description: String) {
        self.name = name
        self.type = type.map({ group in
            return MuscleGroup(rawValue: group)
        })
        self.weight = weight
        self.reps = reps
        self.link = link
        self.description = description
    }
    
    func saveToFirebase(callback: @escaping (_ err: Error?, _ docID: String?) -> Void) async {
        var ref: DocumentReference? = nil
        ref = FirestoreDatabase.shared.database.collection("Exercise").addDocument(data: toDict()) { err in
            if let err = err {
                    callback(err, nil)
                } else {
                    callback(err, ref!.documentID)
                }
        }
    }
    
    func update(callback: @escaping (_ err: Error?) -> Void) async {
        guard let eID = self.id else {return}
        FirestoreDatabase.shared.database.collection("Exercise").document(eID).updateData([
            "weight": self.weight!,
            "reps": self.reps!
        ]) { err in
            callback(err)
        }
    }
    
    
    
//    static func getAllExercisesFromFirebase(callback: @escaping (_ exercises: [[Exercise]]?, _ err: Error?) -> Void) async {
//        FirestoreDatabase.shared.database.collection("Exercise").order(by: "day").getDocuments() { (querySnapshot, err) in
//            if let err = err {
//                    callback(nil, err)
//                } else {
//                    var exercisesArr: [[Exercise]] = []
//                    var ind = -1
//
//                    for document in querySnapshot!.documents {
//                        var data = document.data()
//                        data["id"] = document.documentID
//                        if document.data()["day"] as! Int > ind {
//                            exercisesArr.append([Exercise(dict: data)])
//                            ind += 1
//                        } else {
//                            exercisesArr[exercisesArr.count-1].append(Exercise(dict: data))
//                        }
//                    }
//                    callback(exercisesArr, err)
//                }
//        }
//    }
    
    func toDict() -> [String: Any] {
        var muscleGroups: [String] = []
        for muscleGroup in type {
            muscleGroups.append(muscleGroup!.rawValue)
        }
        return [
            "name": name,
            "type": muscleGroups,
            "reps": reps,
            "weight": weight!,
            "link": link,
            "description": description
        ]
    }
    
    func isEqual(e: Exercise) {
        return e.name == self.name && e.type == self.type && e.reps == self.reps && e.weight == self.weight && e.link == self.link && e.description == self.description
    }
    
    static func dictToList(list: [[String: Any?]]) -> [Exercise] {
        var res: [Exercise] = []
        for dict in list {
            res.append(Exercise(dict: dict))
        }
        return res
    }
    static func MockExercise() -> Exercise {
        return Exercise(dict: [
            "name": "Curls",
            "type": ["Biceps", "Triceps"],
            "reps": "10 10 10",
            "weight": "18.5",
            "link": "N/A",
            "description": "I am a description"
        ])
    }
}
