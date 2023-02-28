//
//  SignupPasswordViewController.swift
//  Research-App
//
//  Created by Levi Harris on 2/27/23.
//

import UIKit
import FirebaseAuth

class SignupPasswordViewController: UIViewController {
    
    @IBOutlet weak var passwordField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func continueButtonPressed(_ sender: Any) {
        GlobalConstants.password = passwordField.text
        
        Auth.auth().createUser(withEmail: GlobalConstants.email!, password: GlobalConstants.password!, completion: { authResult, error in
            if error != nil {
                print("Error")
                return
            }
        })
        
        // Signup -> Welcome
        performSegue(withIdentifier: "showWelcome", sender: nil)
        
        
    }
}
