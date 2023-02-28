//
//  SignupEmailViewController.swift
//  Research-App
//
//  Created by Levi Harris on 2/27/23.
//

import UIKit

class SignupEmailViewController: UIViewController {

    @IBOutlet weak var emailField: UITextField!
    
    @IBOutlet weak var invalidEmailLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        invalidEmailLabel.alpha = 0
    }
    
    @IBAction func continuePressed(_ sender: Any) {
        GlobalConstants.email = emailField.text
        
        if !(verifyEmail(email: GlobalConstants.email!)) {
            print("password must be a UNC address")
            invalidEmailLabel.alpha = 1
            return
        }
        
        self.performSegue(withIdentifier: "showPassword", sender: nil)
    }
    
    func verifyEmail(email: String) -> Bool {
        if email.contains("email.unc.edu") {
            print("exists")
            return true
        }
        return false
    }
}
