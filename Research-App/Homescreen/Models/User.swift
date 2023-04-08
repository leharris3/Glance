//
//  User.swift
//  Research-App
//
//  Created by Levi Harris on 3/31/23.
//

import Foundation
import FirebaseCore
import FirebaseFirestore
import FirebaseAuth

enum AuthResult {
    case success(Bool), failure(Error)
}

class User: NSObject {
    
    var email: String
    var preference: String
    var unlikedProfiles: [String]
    
    override init() {
        print("------------------------------------------------------------")
        print("Initializing user object.")
        let currentUser = Auth.auth().currentUser
        self.unlikedProfiles = []
        self.email = ""
        self.preference = ""
        
        if (currentUser == nil) {
            print("Error retrieving current user.")
            return // Error.
        }
        
        let db = Database.getDatabase()
        
        self.email = currentUser!.email ?? ""
        self.preference = db.getUserField(email: self.email, field: Fields.preference) as? String ?? ""
        self.unlikedProfiles = db.getUserField(email: self.email, field: Fields.unlikedProfiles) as? [String] ?? []
    }
    
    public func getPreference() -> String {
        return self.preference
    }
    
    public func setSeenProfiles(seenProfiles: [String]) {
        return
    }
    
    public func getEmail() -> String {
        return self.email
    }
}
