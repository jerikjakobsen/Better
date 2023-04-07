//
//  FirebaseFirestore.swift
//  Better
//
//  Created by John Jakobsen on 2/13/23.
//

import Foundation
import FirebaseFirestore

class FirestoreDatabase {
    static let shared = FirestoreDatabase()
    let database = Firestore.firestore()
    private init() {}
}
