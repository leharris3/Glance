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
    
    let datePicker: UIDatePicker = UIDatePicker()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func createDatePicker() {
        let toolbar: UIToolbar = UIToolbar()
        toolbar.sizeToFit()
        
        let doneButton = UIBarButtonItem(UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.done, target: nil, action: nil))
        
        toolbar.setItems([doneButton], animated: true)
        
        dobTextField.inputAccessoryView = toolbar
        dobTextField.inputView = datePicker
        datePicker.datePickerMode = .date
        
    }
    
    @objc func donePressed() {
        datePicker.text = "\(datePicker.date)"
        self.view.endEditing(true)
    }
    
    @IBAction func continuePressed(_ sender: Any) {
        //
    }
}
