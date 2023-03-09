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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "MM/dd/yyyy"
        dobTextField.text = formatter.string(from: date)
        
    }
    
    @IBAction func continuePressed(_ sender: Any) {
        let currentDate = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "MM/dd/yyyy"
        
        let canidateDate: Date? = formatter.date(from: dobTextField.text ?? "")
        if ((canidateDate) == nil) {
            print("Error")
        }
        else {
            let ageInSeconds = currentDate.timeIntervalSinceReferenceDate - canidateDate!.timeIntervalSinceReferenceDate
            let ageInYears = Int(ageInSeconds / (60 * 60 * 24 * 365))
            print(ageInYears)
            if (ageInYears < 18 || ageInYears > 99){
                print("Invalid Age")
            }
            else{
                GlobalConstants.user.dateOfBirth = canidateDate
                GlobalConstants.user.age = ageInYears
            }
        }
    }
}
