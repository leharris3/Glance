//
//  ToolbarView.swift
//  Research-App
//
//  Created by Levi Harris on 3/28/23.
//

import Foundation
import UIKit

class ToolbarView: UIToolbar {
    
    init(vc: UIViewController, container: UIView) {
        super.init(frame: .zero)
        
        self.translatesAutoresizingMaskIntoConstraints = false
        self.backgroundColor = .white
        self.clipsToBounds = true
        container.addSubview(self)
        
        let personButton = UIButton()
        personButton.setImage(UIImage(systemName: "person"), for: .normal)
        personButton.tintColor = .black
        personButton.addTarget(self, action: #selector(profileTapped), for: .touchUpInside)
        personButton.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(personButton)
        
        let messageButton = UIButton()
        messageButton.setImage(UIImage(systemName: "message"), for: .normal)
        messageButton.tintColor = .black
        messageButton.addTarget(self, action: #selector(messagesTapped), for: .touchUpInside)
        messageButton.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(messageButton)
        
        
        let constraints = [
            self.bottomAnchor.constraint(equalTo: container.bottomAnchor, constant: 0.0),
            self.leftAnchor.constraint(equalTo: container.leftAnchor, constant: 0.0),
            self.rightAnchor.constraint(equalTo: container.rightAnchor, constant: 0.0),
            self.heightAnchor.constraint(equalToConstant: 50.0),
            
            personButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10.0),
            personButton.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            personButton.widthAnchor.constraint(equalToConstant: 30.0),
            personButton.heightAnchor.constraint(equalToConstant: 30.0),

            messageButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10.0),
            messageButton.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            messageButton.widthAnchor.constraint(equalToConstant: 30.0),
            messageButton.heightAnchor.constraint(equalToConstant: 30.0)
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func profileTapped() {
        // Handle profile icon tap
    }
    
    @objc func messagesTapped() {
        // Handle messages icon tap
    }
}
