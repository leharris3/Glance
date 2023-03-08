//
//  RootViewController.swift
//  Research-App
//
//  Created by Levi Harris on 2/25/23.
//

import UIKit
import FirebaseAuthUI
import FirebaseCore
import FirebaseFirestore

class RootViewController: UIViewController, FUIAuthDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Root -> Feature
        if Auth.auth().currentUser != nil {
            let feature = UIStoryboard(name: "Feature", bundle: nil).instantiateViewController(withIdentifier: "FeatureViewController") as! FeatureViewController
            let navigationController = UIStoryboard(name: "Feature", bundle: nil).instantiateViewController(withIdentifier: "FeatureNavigationController") as! UINavigationController
            navigationController.pushViewController(feature, animated: true)
            
            UIApplication.shared.windows.first?.rootViewController = navigationController
            UIApplication.shared.windows.first?.makeKeyAndVisible()
            
            // Animate Feature Transition
            let options: UIView.AnimationOptions = .transitionCrossDissolve
            let duration: TimeInterval = 0.3
            UIView.transition(with: UIApplication.shared.keyWindow!, duration: duration, options: options, animations: {}, completion: nil)
        }
    }
}
