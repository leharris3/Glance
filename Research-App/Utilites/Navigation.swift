//
//  Navigation.swift
//  Research-App
//
//  Created by Levi Harris on 3/12/23.
//

import UIKit

class Navigation: NSObject {
    
    // MARK: Any -> Onboarding Welcome.
    static func changeRootViewControllerToWelcome() {
        let welcome = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "WelcomeViewController") as! SignupWelcomeViewController
        let navigationController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "OnboardingNavigationController") as! UINavigationController
        navigationController.pushViewController(welcome, animated: true)
        
        UIApplication.shared.windows.first?.rootViewController = navigationController
        UIApplication.shared.windows.first?.makeKeyAndVisible()
        
        // Animate Feature Transition
        let options: UIView.AnimationOptions = .transitionCrossDissolve
        let duration: TimeInterval = 0.2
        UIView.transition(with: UIApplication.shared.keyWindow!, duration: duration, options: options, animations: {}, completion: nil)
    }
    
    // MARK: Any -> Feature.
    static func changeRootViewControllerToFeature() {
        let feature = UIStoryboard(name: "Feature", bundle: nil).instantiateViewController(withIdentifier: "FeatureViewController") as! FeatureViewController
        let navigationController = UIStoryboard(name: "Feature", bundle: nil).instantiateViewController(withIdentifier: "FeatureNavigationController") as! UINavigationController
        // navigationController.pushViewController(feature, animated: true)
        
        UIApplication.shared.windows.first?.rootViewController = navigationController
        UIApplication.shared.windows.first?.makeKeyAndVisible()
        
        // Animate Feature Transition
        let options: UIView.AnimationOptions = .curveEaseInOut
        let duration: TimeInterval = 0.2
        UIView.transition(with: UIApplication.shared.keyWindow!, duration: duration, options: options, animations: {}, completion: nil)
    }
}
