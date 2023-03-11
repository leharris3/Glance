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

class LoginViewController: UIViewController {
    
    
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
    
    @IBAction func loginButton(_ sender: Any) {
        let email: String = emailField.text!
        let password: String = passwordField.text!
        
        // MARK: If a user attempts to login to a half made account, it is deleted.
        
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] authResult, error in
            guard self != nil else { return }
            if error != nil {
                print("Error")
            }
            if ((authResult) != nil) {
                
                // Login -> Feature
                let feature = UIStoryboard(name: "Feature", bundle: nil).instantiateViewController(withIdentifier: "FeatureViewController") as! FeatureViewController
                let navigationController = UIStoryboard(name: "Feature", bundle: nil).instantiateViewController(withIdentifier: "FeatureNavigationController") as! UINavigationController
                navigationController.pushViewController(feature, animated: true)
                
                UIApplication.shared.windows.first?.rootViewController = navigationController
                UIApplication.shared.windows.first?.makeKeyAndVisible()
                
                // Animate Feature Transition
                let options: UIView.AnimationOptions = .transitionCrossDissolve
                let duration: TimeInterval = 0.3
                UIView.transition(with: UIApplication.shared.keyWindow!, duration: duration, options: options, animations: {}, completion: nil)
            }
            else {
                // Forgot Password
                self!.forgotPasswordButton.alpha = 1
                self!.forgotPasswordButton.isEnabled = true
                UIView.animate(withDuration: 0.3) {
                    self!.view.layoutIfNeeded()
                }
            }
        }

    }
    
}
    

