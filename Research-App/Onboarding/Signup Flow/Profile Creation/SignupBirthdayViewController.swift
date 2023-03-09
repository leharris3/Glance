//
//  SignupBirthdayViewController.swift
//  Research-App
//
//  Created by Levi Harris on 3/8/23.
//

import UIKit
import TextFieldEffects

class SignupBirthdayViewController: UIViewController {
        
    @IBOutlet weak var dobTextField: IsaoTextField!
    
    @IBOutlet weak var datePicker: UIDatePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        dobTextField.text = formatter.string(from: date)
        
    }
    
    @IBAction func continuePressed(_ sender: Any) {
        //
    }
}
