//
//  ExerciseRecord.swift
//  Better
//
//  Created by John Jakobsen on 2/12/23.
//

import Foundation
import FirebaseFirestore

class ExerciseRecord {
    let exerciseId: String!
    let weight: Float!
    let reps: String!
    let date: Date?
    init(dict: [String: Any?]) {
        print(dict)
        exerciseId = dict["exerciseID"] as? String ?? ""
        weight = dict["weight"] as? Float ?? 0.0
        reps = dict["reps"] as? String ?? ""
        date = (dict["date"] as? Timestamp)?.dateValue()
    }
    
    init(exerciseID: String, weight: Float, reps: String, date: Date) {
        self.exerciseId = exerciseID
        self.weight = weight
        self.reps = reps
        self.date = date
    }
    
    static func mockRecord() -> ExerciseRecord {
        return ExerciseRecord(dict: [
            "exerciseID": "123",
            "weight": 32.5,
            "reps": "10 10 8",
            "date": Date.now
        ])
    }
    
    func saveToFirebase(callback: @escaping (_ err: Error?, _ docID: String?) -> Void) async {
        var ref: DocumentReference? = nil
        ref = FirestoreDatabase.shared.database.collection("ExerciseRecords").addDocument(data: toDict()) { err in
            if let err = err {
                    callback(err, nil)
                } else {
                    callback(err, ref!.documentID)
                }
        }
    }
    
    static func getAllExerciseRecordsFromFirebase(exerciseID: String, callback: @escaping (_ exerciseRecords: [ExerciseRecord]?, _ err: Error?) -> Void) async {
        FirestoreDatabase.shared.database.collection("ExerciseRecords").whereField("exerciseID", isEqualTo: exerciseID).order(by: "date", descending: true).getDocuments() { (querySnapshot, err) in
            if let err = err {
                    callback(nil, err)
                } else {
                    var exercisesArr: [ExerciseRecord] = []
                    for document in querySnapshot!.documents {
                        var data = document.data()
                        data["id"] = document.documentID
                        exercisesArr.append(ExerciseRecord(dict: data))
                    }
                    callback(exercisesArr, err)
                }
        }
    }
    
    func toDict() -> [String: Any] {
        return [
            "exerciseID": exerciseId!,
            "weight": weight!,
            "reps": reps!,
            "date": Timestamp(date: date!)
        ]
    }
    
}
