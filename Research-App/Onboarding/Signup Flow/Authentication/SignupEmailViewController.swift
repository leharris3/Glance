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

    @IBOutlet weak var fieldsViewBottomConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var emailField: UITextField!
    
    @IBOutlet weak var invalidEmailLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        invalidEmailLabel.alpha = 0
        
        // Move fields on keyboard popup.
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification: )), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    // ???
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Move fields on keyboard popup.
    @objc private func hideKeyboard() {
        self.view.endEditing(true)
    }
    
    // Move fields on keyboard popup.
    @objc private func keyboardWillShow(notification: NSNotification) {
        
        if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as?
            NSValue {
            
            let keyboardHeight = keyboardFrame.cgRectValue.height
            self.fieldsViewBottomConstraint.constant = keyboardHeight
            
            // Animate Constraints
            UIView.animate(withDuration: 0.3) {
                self.view.layoutIfNeeded()
            }
        }
    }
    
    // Move fields on keyboard popup.
    @objc private func keyboardWillHide() {
        self.fieldsViewBottomConstraint.constant = 0
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
    }
    
    @IBAction func continuePressed(_ sender: Any) {
        GlobalConstants.email = emailField.text
        
        // Email string protection.
        if !(verifyEmail(email: GlobalConstants.email!)) {
            print("password must be a UNC address")
            invalidEmailLabel.alpha = 1
            return
        }
        
        // Send Verification Email
        if !(OnboardingUtilites.sendVerificationEmail()){
            invalidEmailLabel.alpha = 1
            UIView.animate(withDuration: 0.3) {
                self.view.layoutIfNeeded()
            }
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
