//
//  SignupPhoneNumberViewController.swift
//  Research-App
//
//  Created by Levi Harris on 2/26/23.
//

import UIKit

class SignupPhoneNumberViewController: UIViewController {
    
    @IBOutlet var keyboardHeightLayoutConstraint: NSLayoutConstraint?
    //
    override func viewDidLoad() {
        super.viewDidLoad()
        //
        //        NotificationCenter.default.addObserver(self,
        //                                               selector: #selector(self.keyboardNotification(notification:)),
        //                                               name: UIResponder.keyboardWillChangeFrameNotification,
        //                                               object: nil)
        //    }
        //
        //    deinit {
        //        NotificationCenter.default.removeObserver(self)
        //    }
        //
        //    @objc func keyboardNotification(notification: NSNotification) {
        //        guard let userInfo = notification.userInfo else { return }
        //
        //        let endFrame = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue
        //        let endFrameY = endFrame?.origin.y ?? 0
        //        let duration:TimeInterval = (userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as? NSNumber)?.doubleValue ?? 0
        //        let animationCurveRawNSN = userInfo[UIResponder.keyboardAnimationCurveUserInfoKey] as? NSNumber
        //        let animationCurveRaw = animationCurveRawNSN?.uintValue ?? UIView.AnimationOptions.curveEaseInOut.rawValue
        //        let animationCurve:UIView.AnimationOptions = UIView.AnimationOptions(rawValue: animationCurveRaw)
        //
        //        if endFrameY >= UIScreen.main.bounds.size.height {
        //            self.keyboardHeightLayoutConstraint?.constant = 0.0
        //        } else {
        //            self.keyboardHeightLayoutConstraint?.constant = endFrame?.size.height ?? 0.0
        //        }
        //
        //        .animate(
        //            withDuration: duration,
        //            delay: TimeInterval(0),
        //            options: animationCurve,
        //            animations: { self.view.layoutIfNeeded() },
        //            completion: nil)
        //    }
    }
}
