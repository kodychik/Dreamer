import Foundation
import SwiftUI
import FirebaseCore
import FirebaseFirestore


struct Dream {
    var userID: String
    var title: String
    var content: String
    var psychoanalysis: String
    var date: Date
    
    var dictionary: [String: Any] {
        return [
            "userID": userID,
            "title": title,
            "content": content,
            "psychoanalysis": psychoanalysis,
            "date": Date()
        ]
    }
}

class DreamRepository {
    
    private let collection = Firestore.firestore().collection("dreams")
    
    func addDream(dream: Dream, completion: @escaping (Error?) -> Void) {
        collection.addDocument(data: dream.dictionary) { error in
            completion(error)
        }
    }
    
    func fetchDreams(for userID: String, completion: @escaping ([Dream]?, Error?) -> Void) {
        collection.whereField("userID", isEqualTo: userID).getDocuments { querySnapshot, error in
            if let error = error {
                completion(nil, error)
                return
            }
            
            let dreams = querySnapshot?.documents.compactMap { document -> Dream? in
                let data = document.data()
                guard let userID = data["userID"] as? String,
                      let title = data["title"] as? String,
                      let content = data["content"] as? String,
                      let psychoanalysis = data["psychoanalysis"] as? String,
                      let timestamp = data["date"] as? Timestamp else { return nil }
                
                let date = timestamp.dateValue()
                return Dream(userID: userID, title: title, content: content, psychoanalysis: psychoanalysis, date: date)
            }
            completion(dreams, nil)
        }
    }
}
