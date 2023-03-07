//
//  SignupConfirmEmailViewController.swift
//  Research-App
//
//  Created by Levi Harris on 3/5/23.
//

import UIKit
import TextFieldEffects

class SignupConfirmEmailViewController: UIViewController {

    @IBOutlet weak var fieldsViewBottomConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var enterCodeFeild: IsaoTextField!
    
    @IBOutlet weak var needAnotherCodePrompt: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        needAnotherCodePrompt.alpha = 0
        needAnotherCodePrompt.isEnabled = false
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
            self.fieldsViewBottomConstraint.constant = keyboardHeight + 20
            
            // Animate Constraints
            UIView.animate(withDuration: 0.5) {
                self.view.layoutIfNeeded()
            }
        }
    }
    
    // Move fields on keyboard popup.
    @objc private func keyboardWillHide() {
        self.fieldsViewBottomConstraint.constant = 0
        UIView.animate(withDuration: 0.5) {
            self.view.layoutIfNeeded()
        }
    }
    
    @IBAction func needAnotherCodePressed(_ sender: Any) {
        // Add Email did not send code.
        OnboardingUtilites.sendVerificationEmail()
    }
    
    @IBAction func continuePressed(_ sender: Any) {
        
        let code: String = enterCodeFeild.text!
        
        if code == String(GlobalConstants.oneTimePasscode){
            performSegue(withIdentifier: "showPickPassword", sender: nil)
        }
        else{
            needAnotherCodePrompt.alpha = 1
            needAnotherCodePrompt.isEnabled = true
        }
    }
}
