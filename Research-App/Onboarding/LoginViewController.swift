//
//  LoginViewController.swift
//  Research-App
//
//  Created by Levi Harris on 2/25/23.
//

import UIKit
import FirebaseCore
import FirebaseFirestore
import FirebaseAuth

class LoginViewController: UIViewController {
    
    
    @IBOutlet weak var emailField: UITextField!
    
    @IBOutlet weak var passwordField: UITextField!
    
    @IBOutlet weak var incorrectField: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        incorrectField.alpha = 0
    }
    
    @IBAction func loginButton(_ sender: Any) {
        let email: String = emailField.text!
        let password: String = passwordField.text!
        
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] authResult, error in
            guard self != nil else { return }
            if error != nil {
                print("Error")
            }
            if ((authResult) != nil) {
                // Login -> Feature
                self?.performSegue(withIdentifier: "showFeatureFromLogin", sender: nil)
                return
            }
            else {
                self!.incorrectField.alpha = 1
            }
        }

    }
    
}
    

