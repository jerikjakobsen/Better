//
//  WeightRecord.swift
//  Better
//
//  Created by John Jakobsen on 2/18/23.
//

import Foundation
import FirebaseFirestore

class WeightRecord {
    let weight: Float!
    let date: Date!
    
    init(weight: Float, date: Date) {
        self.weight = weight
        self.date = date
    }
    func saveToFirebase(callback: @escaping (_ err: Error?) -> Void) async {
        FirestoreDatabase.shared.database.collection("WeightRecords").addDocument(data: [
            "weight": self.weight,
            "date": Timestamp(date: self.date)
        ]) { err in
            callback(err)
        }
    }
    
    static func getAllWeightRecords(callback: @escaping (_ weightRecords: [WeightRecord]?, _ err: Error?) -> Void) async {
        FirestoreDatabase.shared.database.collection("WeightRecords").order(by: "date", descending: true).getDocuments() { (querySnapshot, err) in
            if let err = err {
                    callback(nil, err)
                } else {
                    var weightArr: [WeightRecord] = []
                    for document in querySnapshot!.documents {
                        let data = document.data()
                        weightArr.append(WeightRecord(weight: data["weight"] as! Float, date: (data["date"] as! Timestamp).dateValue()))
                    }
                    callback(weightArr, err)
                }
        }
    }
}
