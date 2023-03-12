//
//  Authentication.swift
//  Research-App
//
//  Created by Levi Harris on 3/12/23.
//

import UIKit
import FirebaseAuth

class Authentication: NSObject {
    
    static func signOut() {
        let firebaseAuth = Auth.auth()
        do {
          try firebaseAuth.signOut()
        } catch let signOutError as NSError {
          print("Error signing out: %@", signOutError)
        }
    }

}
