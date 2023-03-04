//
//  SignupEmailViewController.swift
//  Research-App
//
//  Created by Levi Harris on 2/27/23.
//

import UIKit

class SignupEmailViewController: UIViewController {

    @IBOutlet weak var fieldsViewBottomConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var emailField: UITextField!
    
    @IBOutlet weak var invalidEmailLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification: )), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        invalidEmailLabel.alpha = 0
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
        
        self.performSegue(withIdentifier: "showPassword", sender: nil)
    }
    
    func verifyEmail(email: String) -> Bool {
        
        // Is valid email string?
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        if !emailPred.evaluate(with: email){
            return false
        }
        
        // Is UNC-CH email?
        if !email.contains("email.unc.edu") {
            return false
        }
        
        return true // Valid Email
    }
}
