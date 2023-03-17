//
//  UserCard.swift
//  Research-App
//
//  Created by Levi Harris on 3/7/23.
//

import UIKit

class UserCard: NSObject {
    
    // Onboarding.
    var dateOfBirth: Date? = nil
    var sex = ""
    var preference = ""
    
    // Bio
    var firstName: String? = ""
    var age: Int = 99
    var interests: [String] = []
    var profilePhotos: [Data] = []
    var seenProfiles: [String] = []
    
    // Profile Completion.
    var bio: String? = ""
    var graduatationDate: String? = "" // i.e. class of 2024
    var major: String? = "" // "Computer Science"

}
