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

    // MARK: Attempt to continue onboarding.
    @IBAction func continueButtonPressed(_ sender: Any) {
        
        // Trim whitespaces.
        let password: String? = (passwordField.text ?? "").trimmingCharacters(in: .whitespaces)
        GlobalConstants.password = passwordField.text
        let email: String = GlobalConstants.email!
        
        // Basic password strength.
        if (GlobalConstants.password!.count < 8) {return}
        
        // MARK: Attempt to create profile.
        Auth.auth().signIn(withEmail: email, password: password!) { [weak self] authResult, error in
            
            // MARK: Sign-in success.
            if ((authResult) != nil) {
                
                // Display error and sign out.
                if (error != nil) {
                    Authentication.signOut()
                    self!.creationErrorLabel.text = "Error: Unknown!"
                    self!.creationErrorLabel.alpha = 1
                    return
                }
                
                let db = Firestore.firestore()
                var partialProfileExisits: Bool = true
                
                // Create a reference to user-profile.
                let ref = db.collection("users").document(email)
                ref.getDocument { (document, error) in
                    if (error != nil) { return}
                    if let document = document, document.exists {
                        partialProfileExisits = false
                    }
                }
                
                // MARK: Error, exisiting user.
                if (partialProfileExisits) {
                    Authentication.signOut() // Sign out.
                    self!.creationErrorLabel.text = "Error: Existing Account!"
                    self!.creationErrorLabel.alpha = 1
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
                self!.creationErrorLabel.alpha = 1
            }
        }
    }
}
