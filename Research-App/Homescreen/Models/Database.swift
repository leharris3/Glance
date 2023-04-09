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
    private var profilesSnapshot: [QueryDocumentSnapshot]
    private static var database = Firestore.firestore()
    private var userLists: [String: Any]
    private var observers: [HomescreenViewController] = []

    private override init() {
        print("------------------------------------------------------------")
        print("Initializing database object.")
        
        self.userLists = [:]
        self.profilesSnapshot = []
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
        let ref = Database.database.collection("profiles")
        ref.getDocuments { (querySnapshot, error) in
            if let error = error {
                print("Error fetching documents: \(error.localizedDescription)")
            } else if let profiles = querySnapshot?.documents {
                self.profilesSnapshot = profiles
            }
            self.fetchUserLists()
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
        
        if let profile: QueryDocumentSnapshot = self.profilesSnapshot.first(where: { $0.documentID == email }) {
            let profileDict = profile.data()
            return profileDict[field]
        } else {
            return nil
        }
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
}
