//
//  SignupFirstNameViewController.swift
//  Research-App
//
//  Created by Levi Harris on 3/7/23.
//

import UIKit
import TextFieldEffects
import FirebaseCore
import FirebaseFirestore

class SignupFirstNameViewController: UIViewController {
    
    @IBOutlet weak var firstNameField: IsaoTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // Regex: at least one alphabetical character. No spaces, A-Z, a-z.
    func regex(for text: String) -> Bool {
        let regex = try! NSRegularExpression(pattern: "[A-Za-z]+", options: [.caseInsensitive])
        let range = NSRange(location: 0, length: text.count)
        let matches = regex.matches(in: text, options: [], range: range)
        return matches.first != nil
    }
    
    @IBAction func continuePressed(_ sender: Any) {
        var text: String? = firstNameField.text ?? ""
        text = text!.trimmingCharacters(in: .whitespaces) // Trim whitespaces.
         
        if !(regex(for: text!) || text!.count > 0){
            // Invalid name.
            return
        }
        
        GlobalConstants.user.firstName = firstNameField.text!
        performSegue(withIdentifier: "showBirthday", sender: nil)
    }
}
