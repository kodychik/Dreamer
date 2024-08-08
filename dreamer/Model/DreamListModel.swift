//
//  DreamListModel.swift
//  dreamer
//
//  Created by Kody Chik on 2024-08-07.
//
import FirebaseAuth
import FirebaseCore
import FirebaseFirestore

import Foundation

class DreamListModel: ObservableObject {
    
    //var users_dream : QuerySnapshot?;
    @Published var usersDreams = [Dreamville]()


    var userID = Auth.auth().currentUser?.uid

    var db = Firestore.firestore()
    
    func get_dreams() {
        guard let userID = userID else {
            print("Error: User is not logged in.")
            return
        }
        
        
            //users_dream = try await db.collection(String(userID)).getDocuments()
    //        for document in querySnapshot.documents {
    //            print("\(document.documentID) => \(document.data())")
    //        }
        db.collection(userID).addSnapshotListener{(querySnapshot, error) in
            guard let documents = querySnapshot?.documents else {
                print("no documents")
                return
            }
            
            self.usersDreams = documents.map {(queryDocumentSnapshot) -> Dreamville in
                let data = queryDocumentSnapshot.data()
                let title = String(queryDocumentSnapshot.documentID)
                let date = data["date"] as? String ?? ""
                let dream = data["dream"] as? String ?? ""
                let analysis = data["analysis"] as? String ?? ""
                return Dreamville(title: title, date: date, dream: dream, analysis: analysis)
            }
        }
            
        
    }
    
    
}
