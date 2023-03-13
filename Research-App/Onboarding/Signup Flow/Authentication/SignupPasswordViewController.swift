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
        let email: String = GlobalConstants.email!
        
        // Set global constants.
        GlobalConstants.password = password!
        
        // Basic password strength.
        if (GlobalConstants.password!.count < 8) {return}
        
        // TODO: Redo checks for prexisiting accounts.
        
        // Does a  complete profile exist?
        // Yes:
            // Throw error.
        // No:
            // Does a user exist?
                // Yes:
                    // Can user be authenticated?
                        // Yes
                            // Continue onboarding.
                        // No
                            // Throw Error
                // No:
                    // Can account be created?
                        // Yes
                            // Continue onboarding.
                        // No
                            // Throw error.
        
        // DB reference.
        let db = Firestore.firestore()
        let ref = db.collection("users").document(email)
        var completeProfileExisits: Bool = false
        
        // Check for pre-exisitng, complete account.
        ref.getDocument { (document, error) in
            if (error != nil) { return }
            if let document = document, document.exists {
                completeProfileExisits = true // Complete profile.
            }
            
            // MARK: Error, exisiting user.
            if (completeProfileExisits) {
                self.creationErrorLabel.text = "Error: Existing Account!"
                self.creationErrorLabel.alpha = 1
                return
            }
            else {
                
                // MARK: Attemp sign-in to partial account.
                Auth.auth().signIn(withEmail: email, password: password!) { [weak self] authResult, error in
                    
                    // Continue onboarding.
                    if (authResult != nil && error == nil) {
                        Navigation.changeRootViewControllerToWelcome()
                    }
                }
                
                // MARK: Create user.
                Auth.auth().createUser(withEmail: email, password: password!) { [weak self] authResult, error in
                    
                    // Misc error.
                    if (error != nil) {
                        return
                    }
                    // MARK: Creation success success.
                    if ((authResult) != nil) {
                        // MARK: Login -> Onboarding.
                        Navigation.changeRootViewControllerToWelcome()
                    }
                }
            }
        }
    }
}
