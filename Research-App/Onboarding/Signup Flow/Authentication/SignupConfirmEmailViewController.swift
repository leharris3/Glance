//
//  SignupConfirmEmailViewController.swift
//  Research-App
//
//  Created by Levi Harris on 3/5/23.
//

import UIKit
import TextFieldEffects

class SignupConfirmEmailViewController: UIViewController {

    @IBOutlet weak var enterCodeFeild: IsaoTextField!
    
    @IBOutlet weak var needAnotherCodePrompt: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        needAnotherCodePrompt.alpha = 0
        needAnotherCodePrompt.isEnabled = false
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
