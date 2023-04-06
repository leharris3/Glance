//
//  ProfilesModel.swift
//  Research-App
//
//  Created by Levi Harris on 3/31/23.
//

import Foundation

class ProfileGenerator: NSObject {
    
    var database: Database?
    var profiles: [String: Any]?
    var user: Any
    var unlikedProfiles: [String]
    
    override init() {
        
        print("------------------------------------------------------------")
        print("Initializing profile generator object.")
        
        self.database = Database()
        self.profiles = self.database?.getProfiles()
        self.user = User()
        // self.unlikedProfiles = self.database?.getUserField(email: self.user., field: "unliked_profiles")
        self.unlikedProfiles = []
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
