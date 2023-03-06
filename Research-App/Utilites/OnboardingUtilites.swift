//
//  onboardingUtilites.swift
//  Research-App
//
//  Created by Levi Harris on 3/6/23.
//

import Foundation
import SwiftSMTP
import MessageUI

class OnboardingUtilites: UIViewController {
    
    static func sendVerificationEmail() -> Bool {
        
        var errorFlag: Bool = false
        
        let smtp = SwiftSMTP.SMTP(
            hostname: "smtp.gmail.com",     // SMTP server address
            email: "soleappofficial@gmail.com",        // username to login
            password: "dptwbysenwptkrsw"            // password to login
        )
        
        let soleEmail = Mail.User(name: "Sole", email: "soleappofficial@gmail.com")
        let userEmail = Mail.User(name: "Sole User", email: GlobalConstants.email!)
        
        // Generate Code
        var codeString: String = ""
        for i in (1...6) {
            codeString.append(String((Int.random(in: 1...9))))
        }
        GlobalConstants.oneTimePasscode = Int(codeString)!
        
        print(userEmail)
        
        // Send Verification Email
        let mail = Mail(
            from: soleEmail,
            to: [userEmail],
            subject: "Your Sole Verification Code",
            text: String(GlobalConstants.oneTimePasscode)
        )
        smtp.send(mail) { (error) in
            if error != nil {
                errorFlag = true
                print(error?.localizedDescription)
                return
            }
        }
        
        return !errorFlag // Success
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
