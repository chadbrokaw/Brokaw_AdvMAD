//
//  DogDataController.swift
//  dogs
//
//  Created by Chad Brokaw on 3/30/20.
//  Copyright © 2020 Chad Brokaw. All rights reserved.
//

import Foundation
import Firebase

struct Dog {
    var dogType: String
    var fluffiness: Double
    var notes: String
    var id: String
}

class DogDataController {
    var db: Firestore!
    
    var dogData = [Dog]()
    
    var onDataUpdate: (([Dog]) -> Void)!
    
    init() {
        let settings = FirestoreSettings()
        Firestore.firestore().settings = settings
        
        db = Firestore.firestore()
    }
    
    func loadData() {
        
        let authUserID = Auth.auth().currentUser?.uid
        
        if let userID = authUserID {
            db.collection("users").document(userID).collection("dogs").addSnapshotListener { querySnapshot, error in
                guard let collection = querySnapshot else {
                    print("Error fetching Dog collection: \(error)")
                    return
                }
                
                let docs = collection.documents
                
                self.dogData.removeAll()
                
                for doc in docs {
                    let data = doc.data()
                    
                    let dogType = data["DogType"] as! String
                    let fluffiness = data["Fluffiness"] as! Double
                    let notes = data["Notes"] as! String
                    
                    let id = doc.documentID
                    
                    let dog = Dog(dogType: dogType, fluffiness: fluffiness, notes: notes, id: id)
                    
                    self.dogData.append(dog)
                }
                
                self.onDataUpdate(self.dogData)
            }
        }
        else {
            print("Something wrong. Could not read data or auth user")
        }
        
        
    }
    
    func writeData(dogType: String, fluffiness: Double, notes: String) {
        let authUserID = Auth.auth().currentUser?.uid
        
        if let userID = authUserID {
            db.collection("users").document(userID).collection("dogs").addDocument(data: [
                "DogType": dogType,
                "Fluffiness" : fluffiness,
                "Notes" : notes
            ], completion: {error in
                if let error = error {
                    print("Error adding document: \(error)")
                }
                else {
                    print("New Document Added Successfully")
                }
            })
        }
        else {
            print("Something wrong. Could not read data or auth user")
        }
        
        
    }
}
