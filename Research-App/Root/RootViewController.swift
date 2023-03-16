//
//  RootViewController.swift
//  Research-App
//
//  Created by Levi Harris on 2/25/23.
//

import UIKit
import FirebaseAuthUI
import FirebaseCore
import FirebaseFirestore

class RootViewController: UIViewController, FUIAuthDelegate {
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let currentUser = Auth.auth().currentUser
        
        // MARK: Exisiting user.
        if currentUser != nil {
            let email: String = currentUser!.email ?? ""
            let db = Firestore.firestore()
            var partialProfileExisits: Bool = true
            
            // Create a reference to user-profile.
            let ref = db.collection("users").document(email)
            ref.getDocument { (document, error) in
                if (error != nil) { return }
                if let document = document, document.exists {
                    partialProfileExisits = false
                }
                
                // MARK: Authentication success, exisiting complete profile.
                if !(partialProfileExisits) {
                    Navigation.changeRootViewControllerToFeature()
                }
            }
        }
    }
}
