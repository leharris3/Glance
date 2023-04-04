//
//  ProfilesModel.swift
//  Research-App
//
//  Created by Levi Harris on 3/31/23.
//

import Foundation

class ProfileGenerator: NSObject {
    
    var user: Any
    var unlikedProfiles: [String]
    
    override init() {
        self.user = User()
        self.unlikedProfiles = []
//        self.profiles = ProfileGenerator.load()
    }
    
    static private func loadUnlikedProfiles() -> [String] {
//        let preference: String =
        return []
    }
    
    // Public getter method for next profile to display.
    public func pop() -> [String: Any]? {
        return nil
    }
}
