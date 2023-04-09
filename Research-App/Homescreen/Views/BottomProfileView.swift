//
//  BottomProfileView.swift
//  Research-App
//
//  Created by Levi Harris on 4/5/23.
//

import Foundation
import UIKit
import SwiftUI

class BottomProfileView: UIView {
    
    private var startingPoint: CGPoint?
    private var tapGestureRecognizer: UITapGestureRecognizer!
    private var profileGenerator: ProfileGenerator!
    
    init(vc: UIViewController, container: UIView) {
        
        print("------------------------------------------------------------")
        print("Initializing bottom profile view.")
        
        super.init(frame: vc.view.bounds)
        
        self.setupView()
        self.profileGenerator = ProfileGenerator.getProfileGenerator()
        if let nextProfile = self.profileGenerator?.getNextProfile() {
            self.configure(with: nextProfile)
        }
        
        // Set up constraints
        container.addSubview(self)
        NSLayoutConstraint.activate([
            topAnchor.constraint(equalTo: container.topAnchor, constant: 5),
            bottomAnchor.constraint(equalTo: container.bottomAnchor, constant: -65.0),
            leftAnchor.constraint(equalTo: container.leftAnchor, constant: 10.0),
            rightAnchor.constraint(equalTo: container.rightAnchor, constant: -10.0)
        ])
        
        self.fadeIn()
    }
    
    // Set up the view
    private func setupView() {
        backgroundColor = .white
        layer.cornerRadius = 15
        layer.borderWidth = 2.0
        layer.borderColor = UIColor.black.cgColor
        clipsToBounds = false
        translatesAutoresizingMaskIntoConstraints = false
        alpha = 0.8
        isUserInteractionEnabled = true
    }
    
    
    public func configure(with: String) {
        
    }
    
    public override func didChangeValue(forKey key: String) {
        if (key == "Profile Dismissed"){
            if let email = self.profileGenerator?.getNextProfile() {
                self.configure(with: email)
            }
            self.fadeIn()
        }
    }
    
    private func fadeIn() {
        transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
        self.alpha = 0.0
        UIView.animate(withDuration: 0.3, delay: 0.0, options: .curveEaseInOut, animations: {
            self.transform = CGAffineTransform.identity
            self.alpha = 1.0
        }, completion: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

