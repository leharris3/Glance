//
//  RootViewController.swift
//  Research-App
//
//  Created by Levi Harris on 2/25/23.
//

import UIKit
import FirebaseAuthUI

class RootViewController: UIViewController, FUIAuthDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Root -> Feature
        if Auth.auth().currentUser != nil {
            let feature = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "FeatureViewController") as! FeatureViewController
            let navigationController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "FeatureNavigationController") as! UINavigationController
            navigationController.pushViewController(feature, animated: true)
            
            UIApplication.shared.windows.first?.rootViewController = navigationController
            UIApplication.shared.windows.first?.makeKeyAndVisible()
            
            print("Pre-Exisiting User")
        }
        else {
            print("not logged in lol")
        }
    }
}
