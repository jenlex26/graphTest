//
//  FirebaseDatabase.swift
//  graphTest
//
//  Created by Javier Hernandez on 10/03/22.
//

import FirebaseDatabase

class FirebaseDatabaseController {
    private let db = Database.database().reference()
    
    func observe(endpoint: String, event: DataEventType = .value, completion: @escaping (DataSnapshot) -> Void) {
        let ref = db.child(endpoint)
        ref.observe(event, with: completion)
    }
}
