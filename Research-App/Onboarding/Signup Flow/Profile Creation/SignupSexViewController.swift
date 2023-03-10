//
//  SignupSexViewController.swift
//  Research-App
//
//  Created by Levi Harris on 3/9/23.
//

import UIKit

class SignupSexViewController: UIViewController {

    @IBOutlet weak var manButton: UIButton!

    @IBOutlet weak var womanButton: UIButton!
    
    @IBOutlet weak var otherButton: UIButton!
    
    private var manFlag = false
    private var womanFlag = false
    private var otherFlag = false
    private var sex = ""
    
    override func viewDidLoad() {
        manButton.tintColor = .white
        womanButton.tintColor = .white
        otherButton.tintColor = .white

        super.viewDidLoad()
    }
    
    func setColor(button: UIButton){
        button.tintColor = UIColor(hex: "EF476F")
    }
    
    func resetColors(buttonOne: UIButton, buttonTwo: UIButton){
        buttonOne.tintColor = .white
        buttonTwo.tintColor = .white

    }
    
    @IBAction func manButtonPressed(_ sender: Any) {
        if !(manFlag) {
           setColor(button: manButton)
            resetColors(buttonOne: womanButton, buttonTwo: otherButton)
            womanFlag = false
            otherFlag = false
            sex = "M" // Sex = Man
        }
        else {
            manButton.tintColor = .white
            sex = "" // No sex.
        }
        manFlag = !manFlag // Flip the flag.
    }
    
    @IBAction func womanButtonPressed(_ sender: Any) {
        if !(womanFlag) {
           setColor(button: womanButton)
            resetColors(buttonOne: manButton, buttonTwo: otherButton)
            manFlag = false
            otherFlag = false
            sex = "W" // Sex = Woman
        }
        else {
            womanButton.tintColor = .white
            sex = "" // No sex.
        }
        womanFlag = !womanFlag // Flip the flag.
    }
    
    @IBAction func otherButton(_ sender: Any) {
        if !(otherFlag) {
           setColor(button: otherButton)
            resetColors(buttonOne: manButton, buttonTwo: womanButton)
            manFlag = false
            womanFlag = false
            sex = "O" // Sex = Other
        }
        else {
            otherButton.tintColor = .white
            sex = "" // No sex.
        }
        otherFlag = !womanFlag // Flip the flag.
    }
    
    // Indentity -> Preferences
    @IBAction func buttonPressed(_ sender: Any) {
        if(sex!= "") {
            performSegue(withIdentifier: "showPreferences", sender: nil)
        }
    }
}

    // https://cocoacasts.com/from-hex-to-uicolor-and-back-in-swift
    // Hex -> CGColor
extension UIColor {
    
    convenience init?(hex: String) {
        var hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        hexSanitized = hexSanitized.replacingOccurrences(of: "#", with: "")
        
        var rgb: UInt32 = 0
        
        var r: CGFloat = 0.0
        var g: CGFloat = 0.0
        var b: CGFloat = 0.0
        var a: CGFloat = 1.0
        
        let length = hexSanitized.count
        
        guard Scanner(string: hexSanitized).scanHexInt32(&rgb) else { return nil }
        
        if length == 6 {
            r = CGFloat((rgb & 0xFF0000) >> 16) / 255.0
            g = CGFloat((rgb & 0x00FF00) >> 8) / 255.0
            b = CGFloat(rgb & 0x0000FF) / 255.0
            
        } else if length == 8 {
            r = CGFloat((rgb & 0xFF000000) >> 24) / 255.0
            g = CGFloat((rgb & 0x00FF0000) >> 16) / 255.0
            b = CGFloat((rgb & 0x0000FF00) >> 8) / 255.0
            a = CGFloat(rgb & 0x000000FF) / 255.0
            
        } else {
            return nil
        }
        self.init(red: r, green: g, blue: b, alpha: a)
    }
}
