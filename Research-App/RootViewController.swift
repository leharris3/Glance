//
//  RootViewController.swift
//  Research-App
//
//  Created by Levi Harris on 2/25/23.
//

import UIKit
import FirebaseAuthUI

class RootViewController: UIViewController, FUIAuthDelegate {
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        if Auth.auth().currentUser != nil {
            let featureViewController = self.storyboard?.instantiateViewController(withIdentifier: "FeatureViewController") as? FeatureViewController
            self.view.window?.rootViewController = featureViewController
            self.view.window?.makeKeyAndVisible() // Animation
            print("executed")
            
        } else {
            print("No user is logged in")
        }
        
    }
}
