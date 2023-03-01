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
    
    @IBOutlet weak var forgotPasswordButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        forgotPasswordButton.alpha = 0
        forgotPasswordButton.isEnabled = false
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
                let feature = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "FeatureViewController") as! FeatureViewController
                UIApplication.shared.windows.first?.rootViewController = feature
                UIApplication.shared.windows.first?.makeKeyAndVisible()
                
                print("Login Success")
            }
            else {
                self!.forgotPasswordButton.alpha = 1
                self!.forgotPasswordButton.isEnabled = true
            }
        }

    }
    
}
    

