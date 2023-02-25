//
//  SignupViewController.swift
//  Research-App
//
//  Created by Levi Harris on 2/25/23.
//

import UIKit
import FirebaseCore
import FirebaseFirestore
import FirebaseAuth

class SignupViewController: UIViewController {

    @IBOutlet weak var emailField: UITextField!
    
    @IBOutlet weak var passwordField: UITextField!
    
    @IBOutlet weak var signupField: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func signupField(_ sender: Any) {
        
        let email: String = emailField.text!
        let password: String = passwordField.text!
        
        Auth.auth().createUser(withEmail: email, password: password, completion: { authResult, error in
            if error != nil {
                print("Error")
                return
            }
        })
        
        print("Account Creation Success!")
        
        // Transition to Login
        performSegue(withIdentifier: "showLogin", sender: nil)
        
        
        // leviharris555@gmail.com

    }
    
}
