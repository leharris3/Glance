//
//  ProfilesModel.swift
//  Research-App
//
//  Created by Levi Harris on 3/31/23.
//

import Foundation

// TODO: Current loads all users as unloaded users.

class ProfileGenerator: NSObject {
    
    private var user: User
    private var unseenProfiles: [String]
    private var seenProfiles: [String]
    private static var profileGenerator: ProfileGenerator? = nil
    
    private override init() {
        
        print("------------------------------------------------------------")
        print("Initializing profile generator object.")
        
        
        self.user = User()
        self.unseenProfiles = []
        self.seenProfiles = []
        
        super.init()
        
        self.loadPreferedProfilesAndUpdate()
    }
    
    public static func getProfileGenerator() -> ProfileGenerator {
        if (ProfileGenerator.profileGenerator == nil) { ProfileGenerator.profileGenerator = ProfileGenerator() }
        return ProfileGenerator.profileGenerator!
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
        print("unseen profiles: ", self.unseenProfiles)
    }
    
    // Pop current profile off of profile stack.
    public func pop() {
        if (unseenProfiles.count > 0) {
            unseenProfiles.remove(at: 0)
        }
    }
    
    public func getCurrentProfile() -> String? {
        if (unseenProfiles.count > 0) {
            return unseenProfiles[0]
        }
        return nil
    }
    
    public func getNextProfile() -> String? {
        if (unseenProfiles.count > 1) {
            return unseenProfiles[1] as! String
        }
        return nil
    }
}
