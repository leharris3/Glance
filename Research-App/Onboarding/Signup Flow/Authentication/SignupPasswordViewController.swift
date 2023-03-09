//
//  SignupPasswordViewController.swift
//  Research-App
//
//  Created by Levi Harris on 2/27/23.
//

import UIKit
import FirebaseAuth

class SignupPasswordViewController: UIViewController {
    
    var viewHasLoaded: Bool = false
    var err = false
    
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
    
    func createUser() {
        Auth.auth().createUser(withEmail: GlobalConstants.email!, password: GlobalConstants.password!, completion: {
            authResult, error in
            if error != nil {
                print("2")
                self.err = true
                self.creationErrorLabel.alpha = 1
                return
            }
        })
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

    @IBAction func continueButtonPressed(_ sender: Any) {
        GlobalConstants.password = passwordField.text
        
        // Basic password strength.
        if (GlobalConstants.password!.count < 8) {return}

        print("1")
        
        let queue = DispatchQueue(label: "com.app.queue")
            queue.sync {
                createUser()
            }
        
        print(err)
        
        print("3")
        
        // Signup -> Welcome
        if (!err) {
            self.performSegue(withIdentifier: "showWelcome", sender: nil)
        }
        
        // Overwrite a function on textFieldEdit to attempt to create a profile
    }
}
