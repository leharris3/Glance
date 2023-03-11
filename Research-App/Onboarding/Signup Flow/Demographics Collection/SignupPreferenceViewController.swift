//
//  SignupPreferenceViewController.swift
//  Research-App
//
//  Created by Levi Harris on 3/10/23.
//

import UIKit

class SignupPreferenceViewController: UIViewController {

    @IBOutlet weak var menButton: UIButton!
    
    @IBOutlet weak var womenButton: UIButton!
    
    private var menFlag = false
    private var womenFlag = false
    private var preference = ""
    
    override func viewDidLoad() {
        menButton.tintColor = .white
        womenButton.tintColor = .white
        super.viewDidLoad()
    }
    
    @IBAction func menButtonPressed(_ sender: Any) {
        if !(menFlag) {
            menButton.tintColor = UIColor(hex: "EF476F")
            if (womenFlag) {
                preference = "B"
            }
            else {
                preference = "M"
            }
        }
        else {
            menButton.tintColor = .white
            if (womenFlag) {
                preference = "W"
            }
            else
            {
                preference = ""
            }
        }
        menFlag = !menFlag
    }
    
    @IBAction func womenButtonPressed(_ sender: Any) {
        if !(womenFlag) {
            womenButton.tintColor = UIColor(hex: "EF476F")
            if (menFlag) {
                preference = "B"
            }
            else {
                preference = "M"
            }
        }
        else {
            womenButton.tintColor = .white
            if (menFlag) {
                preference = "W"
            }
            else {
                preference = ""
            }
        }
        womenFlag = !womenFlag
    }
    
    @IBAction func continueButton(_ sender: Any) {
        if (preference != ""){
            GlobalConstants.user.preference = preference
            print(preference    )
            performSegue(withIdentifier: "showInterests", sender: nil)
        }
    }
}
