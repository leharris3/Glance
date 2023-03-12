//
//  LoginViewController.swift
//  Research-App
//
//  Created by Levi Harris on 2/25/23.
//

import UIKit
import FirebaseCore
import FirebaseFirestore
import FirebaseAuth
import FirebaseDatabase

class LoginViewController: UIViewController {
    
    // Buttons + fields.
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var forgotPasswordButton: UIButton!
    @IBOutlet weak var fieldsViewBottomConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        forgotPasswordButton.alpha = 0
        forgotPasswordButton.isEnabled = false
        
        // Move fields on keyboard popup.
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification: )), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
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
        self.fieldsViewBottomConstraint.constant = 20
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
    }
    
    // MARK: Attempt login.
    @IBAction func loginButton(_ sender: Any) {
        let email: String = emailField.text!
        let password: String = passwordField.text!
        
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] authResult, error in
            // Sign-in success.
            if ((authResult) != nil) {
                var userExists: Bool = false
                if (error != nil) {return}
                let db = Firestore.firestore()
                
                // Create a reference to user-profile.
                let ref = db.collection("user-info").document(email)
                ref.getDocument { (document, error) in
                    if (error != nil) { return}
                    if let document = document, document.exists {
                        userExists = true
                    }
                }
                print("User exists: " + String(userExists))
                
                // MARK: Login -> Feature [Success].
                if (userExists) {
                    Navigation.changeRootViewControllerToFeature()
                }
                else {
                    // MARK: Continue onboarding.
                    // Set global constants.
                    GlobalConstants.email = email
                    GlobalConstants.password = password
                    
                    // MARK: Login -> Onboarding.
                    Navigation.changeRootViewControllerToWelcome()
                }
            }
            else {
                self!.forgotPasswordButton.alpha = 1
                self!.forgotPasswordButton.isEnabled = true
                UIView.animate(withDuration: 0.3) {
                    self!.view.layoutIfNeeded()
                }
            }
        }
    }
}
                                                            
