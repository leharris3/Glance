//
//  UserCard.swift
//  Research-App
//
//  Created by Levi Harris on 3/7/23.
//

import UIKit

class UserCard: NSObject {
    
    // Onboarding.
    var firstName: String? = ""
    var dateOfBirth: Date? = nil
    var age: Int = 99
    var sex = ""
    var preference = ""
    var interests: [String] = []
    var profilePhotos: [Data] = []
    
    // Profile Completion.
    var bio: String? = ""
    var graduatationDate: String? = "" // i.e. class of 2024
    var major: String? = "" // "Computer Science"

}
