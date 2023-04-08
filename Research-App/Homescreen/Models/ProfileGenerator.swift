//
//  ProfilesModel.swift
//  Research-App
//
//  Created by Levi Harris on 3/31/23.
//

import Foundation

class ProfileGenerator: NSObject {
    
    var user: User
    var unseenProfiles: [String]
    var seenProfiles: [String]
    
    override init() {
        
        print("------------------------------------------------------------")
        print("Initializing profile generator object.")
        
        self.user = User()
        self.seenProfiles = []
        self.unseenProfiles = []
        super.init()
        
        self.loadPreferedProfilesAndUpdate()
        
        }
    
    private func loadPreferedProfilesAndUpdate() {
        
        let db = Database.getDatabase()
        
        if (user.preference == "M") {
            self.unseenProfiles = (db.getUserPool(pool: "Males"))
        }
        else if (user.preference == "W") {
            self.unseenProfiles = (db.getUserPool(pool: "Females"))
        }
        else if (user.preference == "B"){
            self.unseenProfiles = (db.getUserPool(pool: "All"))
        }
        else {
            print("Error loading prefered user pool, bad string.")
            self.unseenProfiles = []
        }
        // print(self.unseenProfiles)
    }
    
    static private func loadUnlikedProfiles() -> [String] {
        return []
    }
    
    // Pop current profile off of profile stack.
    public func pop() {
        return
    }
    
    public func getCurrentProfile() -> [String: Any] {
        return [:]
    }
    
    public func getNextProfile() -> [String: Any] {
        return [:]
    }
}
