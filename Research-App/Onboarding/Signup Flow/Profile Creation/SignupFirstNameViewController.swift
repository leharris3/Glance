//
//  SignupFirstNameViewController.swift
//  Research-App
//
//  Created by Levi Harris on 3/7/23.
//

import UIKit
import TextFieldEffects
import FirebaseCore
import FirebaseFirestore

class SignupFirstNameViewController: UIViewController {
    
    @IBOutlet weak var firstNameField: IsaoTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func continuePressed(_ sender: Any) {
        
        // Store DB Info
        if (firstNameField.text) != nil {
            GlobalConstants.db.collection("user-info").document(GlobalConstants.email!).setData(["first_name": firstNameField.text], merge: true)
            performSegue(withIdentifier: "showBirthday", sender: nil)
        }
        else {
            // Show some error
        }
    }
}
