//
//  SignupPasswordViewController.swift
//  Research-App
//
//  Created by Levi Harris on 2/27/23.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

class SignupPasswordViewController: UIViewController {
    
    // Prevent animating views on view initial loading.
    var viewHasLoaded: Bool = false
    
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
            UIView.animate(withDuration: 0.3) {
                self.view.layoutIfNeeded()
            }
        }
    }
    
    // Move views on keyboard popup.
    @objc private func keyboardWillHide() {
        if !(viewHasLoaded){
         viewHasLoaded = true
        }
        else {
            self.fieldsViewBottomConstraint.constant = 20
            UIView.animate(withDuration: 0.3) {
                self.view.layoutIfNeeded()
            }
        }
    }

    // Continue button pressed. Transition -> Onboarding.
    @IBAction func continueButtonPressed(_ sender: Any) {
        
        // Trim whitespaces.
        let password: String? = (passwordField.text ?? "").trimmingCharacters(in: .whitespaces)
        GlobalConstants.password = passwordField.text
        
        // Basic password strength.
        if (GlobalConstants.password!.count < 8) {return}
        
        // MARK: Attempt to create profile.
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] authResult, error in
            
            // MARK: Sign-in success.
            if ((authResult) != nil) {
                
                if (error != nil) {
                    // Sign-Out
                    Authentication.signOut()
                    self!.forgotPasswordButton.titleLabel?.text = "Error: Unknown!"
                    self!.forgotPasswordButton.alpha = 1
                    self!.forgotPasswordButton.isEnabled = true
                    return
                }
                
                let db = Firestore.firestore()
                let userExists: Bool = false
                
                // Create a reference to user-profile.
                let ref = db.collection("user-info").document(email)
                ref.getDocument { (document, error) in
                    if (error != nil) { return}
                    if let document = document, document.exists {
                        userExists = true
                    }
                }
                print("User exists: " + String(userExists))
                
                // MARK: Error, exisiting user.
                if (userExists) {
                    Authentication.signOut() // Sign out.
                    self!.forgotPasswordButton.titleLabel?.text = "Error: Existing Account!"
                    self!.forgotPasswordButton.alpha = 1
                    self!.forgotPasswordButton.isEnabled = true
                    return
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
            }
        }
    }
}
