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
        
        let password: String? = (passwordField.text ?? "").trimmingCharacters(in: .whitespaces) // Trim whitespaces.
        GlobalConstants.password = passwordField.text
        
        // Basic password strength.
        if (GlobalConstants.password!.count < 8) {return}
        
        // Create a new user w/ incomplete profile.
        Auth.auth().createUser(withEmail: GlobalConstants.email!, password: GlobalConstants.password ?? "", completion: {
            authResult, error in
            if (error == nil) {
                // Success.
                let email = GlobalConstants.email!
                let db = Firestore.firestore()
                
                // Set profile_complete flag to false.
                db.collection("user-info").document(email).setData(["profile_complete": false], merge: true)
                
                // Authentication -> Onboarding.
                let welcome = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "WelcomeViewController") as! SignupWelcomeViewController
                let navigationController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "OnboardingNavigationController") as! UINavigationController
                navigationController.pushViewController(welcome, animated: true)
                
                UIApplication.shared.windows.first?.rootViewController = navigationController
                UIApplication.shared.windows.first?.makeKeyAndVisible()
                
                // Animate Feature Transition
                let options: UIView.AnimationOptions = .transitionCrossDissolve
                let duration: TimeInterval = 0.3
                UIView.transition(with: UIApplication.shared.keyWindow!, duration: duration, options: options, animations: {}, completion: nil)
            }
            else {
                self.creationErrorLabel.alpha = 1
                UIView.animate(withDuration: 0.3) {
                    self.view.layoutIfNeeded()
                }
            }
        })
    }
}
