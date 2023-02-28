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
    
    @IBOutlet weak var creationErrorLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        creationErrorLabel.alpha = 0
    }
    
    @IBAction func continueButtonPressed(_ sender: Any) {
        GlobalConstants.password = passwordField.text
        
        Auth.auth().createUser(withEmail: GlobalConstants.email!, password: GlobalConstants.password!, completion: { authResult, error in
            if error != nil {
                self.creationErrorLabel.alpha = 1
                return
            }
        })
        
        // Signup -> Welcome
        performSegue(withIdentifier: "showWelcome", sender: nil)
        
        
    }
}
