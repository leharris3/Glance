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
    
    @IBOutlet weak var fieldsViewBottomConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification: )), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        super.viewDidLoad()
        creationErrorLabel.alpha = 0
    }
    
    @objc private func hideKeyboard() {
        self.view.endEditing(true)
    }
    
    @objc private func keyboardWillShow(notification: NSNotification) {
        
        if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as?
            NSValue {
            
            let keyboardHeight = keyboardFrame.cgRectValue.height
            self.fieldsViewBottomConstraint.constant = keyboardHeight
            
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
