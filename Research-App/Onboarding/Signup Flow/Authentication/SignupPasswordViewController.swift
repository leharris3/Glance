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
        super.viewDidLoad()
        creationErrorLabel.alpha = 0
        
        // Move views on keyboard popup.
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification: )), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    // Move views on keyboard popup.
    @objc private func hideKeyboard() {
        self.view.endEditing(true)
    }
    
    // Move views on keyboard popup.
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
    
    // Move views on keyboard popup.
    @objc private func keyboardWillHide() {
        self.fieldsViewBottomConstraint.constant = 0
        UIView.animate(withDuration: 0.5) {
            self.view.layoutIfNeeded()
        }
    }

    @IBAction func continueButtonPressed(_ sender: Any) {
        GlobalConstants.password = passwordField.text
        
        if (GlobalConstants.password!.count < 8) {return} // Basic password strength
        
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
