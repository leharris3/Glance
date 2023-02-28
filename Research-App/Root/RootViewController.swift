//
//  RootViewController.swift
//  Research-App
//
//  Created by Levi Harris on 2/25/23.
//

import UIKit
import FirebaseAuthUI

class RootViewController: UIViewController, FUIAuthDelegate {

//    let backgroundGradient: UIView = {
//
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if Auth.auth().currentUser != nil {

            performSegue(withIdentifier: "showFeatureLoggedIn", sender: nil)
            
        } else {
            print("No user is logged in")
        }
        
    }
}
