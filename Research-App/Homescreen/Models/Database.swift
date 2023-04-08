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
    
    private static var db: Database?
    private static var database = Firestore.firestore()
    private var userProfiles: [String: Any]
    private var userLists: [String: Any]
    private var observers: [HomescreenViewController] = []

    private override init() {
        print("------------------------------------------------------------")
        print("Initializing database object.")
        self.userProfiles = [:]
        self.userLists = [:]
        super.init()
        self.fetchUserProfiles()
    }
    
    public static func getDatabase() -> Database {
        if (Database.db == nil) {Database.db = Database()}
        return Database.db!
    }
    
    public func addObserver(viewController: HomescreenViewController) {
        self.observers.append(viewController)
    }
    
    private func notifyObservers() {
        for observer in observers {
            observer.didDataFinishLoading()
        }
    }
    
    private func fetchUserProfiles() {
        let ref = Database.database.collection("users").document("user-profiles")
        ref.getDocument { (document, error) in
            if let error = error {
            } else if let document = document, document.exists {
                let userProfiles = document.data()!
                // print(userProfiles)
                self.userProfiles = userProfiles
                print("User profiles loaded")
                self.fetchUserLists()
            } else {
                let error = NSError(domain: "fetchUserProfiles", code: 0, userInfo: [NSLocalizedDescriptionKey: "User profiles document does not exist"])
            }
        }
    }

    private func fetchUserLists() {
        let ref = Database.database.collection("users").document("user-lists")
        ref.getDocument { (document, error) in
            if let error = error {
            } else if let document = document, document.exists {
                let userLists = document.data()!
                // print("User lists loaded")
                print(userLists)
                self.userLists = userLists
                self.notifyObservers()
            } else {
                let error = NSError(domain: "fetchUserProfiles", code: 0, userInfo: [NSLocalizedDescriptionKey: "User profiles document does not exist"])
            }
        }
    }
    
    public func getUserField(email: String, field: String) -> Any? {
        print(self.userProfiles)
        if (self.userProfiles[email] != nil) {
            let profile = self.userProfiles[email]
            print(profile)
            if ((profile as! [String: Any])[field] != nil) {
                return (profile as! [String: Any])[field]
            }
        }
        return nil
    }
    
    public func getUserPool(pool: String) -> [String] {
        
        if (pool == "Males") {
            return (self.userLists["male-users"] as! [String]) ?? []
        }
        else if (pool == "Females") {
            return (self.userLists["female-users"] as! [String]) ?? []
        }
        else if (pool == "All") {
            return (self.userLists["all-users"] as! [String]) ?? []
        }
        else { return [] }
    }
    
    public func setUserProfile(email: String, profile: [String: Any]) {
        
    }
    
    private func getProfiles() -> [String: Any] {
        return self.userProfiles
    }
}
