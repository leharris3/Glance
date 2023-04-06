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
    var database: Database
    
    override init() {
        print("------------------------------------------------------------")
        print("Initializing user object.")
        let currentUser = Auth.auth().currentUser
        self.database = Database()
        self.unlikedProfiles = []
        self.email = ""
        self.preference = ""
        
//        if (currentUser == nil) {
//            print("Error retrieving current user.")
//            return // Error.
//        }
//        do {
//            self.email = currentUser!.email!
//            self.preference = self.database.getUserField(email: self.email, field: Fields.preference)
//            self.unlikedProfiles = self.database.getUserField(email: self.email, field: Fields.unlikedProfiles)
//        }
//        catch {
//            print("Error getting logged-in user fields.")
//            return
//        }
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
