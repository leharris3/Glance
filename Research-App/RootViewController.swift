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
            
            performSegue(withIdentifier: "showFeatureLoggedIn", sender: nil)
            
        } else {
            print("No user is logged in")
        }
        
    }
}
