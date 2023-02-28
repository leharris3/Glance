//
//  SignupEmailViewController.swift
//  Research-App
//
//  Created by Levi Harris on 2/27/23.
//

import UIKit

class SignupEmailViewController: UIViewController {

    @IBOutlet weak var emailField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func continuePressed(_ sender: Any) {
        GlobalConstants.email = emailField.text
    }
}
