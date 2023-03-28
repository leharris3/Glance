//
//  Profile.swift
//  Research-App
//
//  Created by Levi Harris on 3/17/23.
//

import UIKit

class Profile: NSObject {
    
    // Bio
    var firstName: String?
    var age: Int
    var interests: [String]
    var profilePhotos: [Data]
    var seenProfiles: [String]
    
    init(firstName: String? = nil, age: Int, interests: [String], profilePhotos: [Data], seenProfiles: [String]) {
        self.firstName = firstName
        self.age = age
        self.interests = interests
        self.profilePhotos = profilePhotos
        self.seenProfiles = seenProfiles
    }

}
