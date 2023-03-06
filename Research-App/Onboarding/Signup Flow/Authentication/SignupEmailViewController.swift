//
//  SignupEmailViewController.swift
//  Research-App
//
//  Created by Levi Harris on 2/27/23.
//

import UIKit
import MessageUI
import SwiftSMTP

class SignupEmailViewController: UIViewController {
    
    let smtp = SMTP(
        hostname: "smtp.gmail.com",     // SMTP server address
        email: "soleappofficial@gmail.com",        // username to login
        password: "tneytntlwelsqsug"            // password to login
    )

    @IBOutlet weak var fieldsViewBottomConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var emailField: UITextField!
    
    @IBOutlet weak var invalidEmailLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        invalidEmailLabel.alpha = 0
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification: )), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        let drLight = Mail.User(name: "Sole", email: "soleappofficial@gmail.com")
        let megaman = Mail.User(name: "Megaman", email: "leviharris555@gmail.com")

        // Send Verification Email
        let mail = Mail(
            from: drLight,
            to: [megaman],
            subject: "Humans and robots living together in harmony and equality.",
            text: "That was my ultimate wish."
        )

        smtp.send(mail) { (error) in
            if let error = error {
                print(error)
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc private func hideKeyboard() {
        self.view.endEditing(true)
    }
    
    @objc private func keyboardWillShow(notification: NSNotification) {
        
        if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as?
            NSValue {
            
            let keyboardHeight = keyboardFrame.cgRectValue.height
            self.fieldsViewBottomConstraint.constant = -keyboardHeight
            
            // Animate Constraints
            UIView.animate(withDuration: 0.5) {
                self.view.layoutIfNeeded()
            }
        }
    }
    
    @objc private func keyboardWillHide() {
        self.fieldsViewBottomConstraint.constant = 0
        UIView.animate(withDuration: 0.5) {
            self.view.layoutIfNeeded()
        }
    }
    
    @IBAction func continuePressed(_ sender: Any) {
        GlobalConstants.email = emailField.text
        
        if !(verifyEmail(email: GlobalConstants.email!)) {
            print("password must be a UNC address")
            invalidEmailLabel.alpha = 1
            return
        }
        
        self.performSegue(withIdentifier: "showEmailConfirmation", sender: nil)
    }
    
    func verifyEmail(email: String) -> Bool {
        
        // Is valid email string?
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        if !emailPred.evaluate(with: email){
            return false
        }
        
        // Is UNC-CH email?
        if !email.contains("unc.edu") {
            return false
        }
        
        return true // Valid Email
    }
}
