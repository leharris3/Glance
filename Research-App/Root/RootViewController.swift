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
    
    @IBOutlet weak var signupButton: UIButton!
    
    @IBOutlet weak var signinButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        signupButton.layer.borderWidth = 1.5
        signupButton.layer.borderColor = UIColor.white.cgColor
        signupButton.layer.cornerRadius = 24
        
        signinButton.layer.borderWidth = 1.5
        signinButton.layer.borderColor = UIColor.white.cgColor
        signinButton.layer.cornerRadius = 24
        
        if Auth.auth().currentUser != nil {

            performSegue(withIdentifier: "showFeatureLoggedIn", sender: nil)
            
        } else {
            print("No user is logged in")
        }
        
    }
}
