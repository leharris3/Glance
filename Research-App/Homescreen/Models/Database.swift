//
//  Database.swift
//  Research-App
//
//  Created by Levi Harris on 4/1/23.
//

import Foundation
import FirebaseCore
import FirebaseFirestore
import FirebaseAuth

// MARK: All database getter methods.

class Database: NSObject {
    
    private static var database = Firestore.firestore()
    private var userProfiles: [String: Any]
    
    override init() {
        
        print("------------------------------------------------------------")
        print("Initializing database object.")
        
        var userProfiles: [String: Any] = [:]
        Database.fetchUserProfiles { result in
            switch result {
            case .success(let fetchedProfiles):
                userProfiles = fetchedProfiles
                // Handle the user profiles dictionary
                print("User profiles fetched successfully")
            case .failure(let error):
                // Handle the error
                print("Error fetching user profiles:", error.localizedDescription)
            }
        }
        self.userProfiles = userProfiles
    }
    
    private static func fetchUserProfiles(completion: @escaping (Result<[String: Any], Error>) -> Void) {
        let ref = Database.database.collection("users").document("user-profiles")
        ref.getDocument { (document, error) in
            if let error = error {
                completion(.failure(error))
            } else if let document = document, document.exists {
                let userProfiles = document.data()!
                completion(.success(userProfiles))
            } else {
                let error = NSError(domain: "fetchUserProfiles", code: 0, userInfo: [NSLocalizedDescriptionKey: "User profiles document does not exist"])
                completion(.failure(error))
            }
        }
    }

    
    public func getUserField(email: String, field: String) -> Any? {
        return nil
    }
    
    public func setUserField(email: String, field: String, with: Any?) {
        
    }
    
    public func getProfiles() -> [String: Any] {
        return self.userProfiles
    }
}
