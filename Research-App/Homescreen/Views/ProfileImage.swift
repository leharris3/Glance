//
//  ProfileImage.swift
//  Research-App
//
//  Created by Levi Harris on 4/6/23.
//

import Foundation
import UIKit

class ProfileImage: UIImageView {
    
    private var profileGenerator: ProfileGenerator
    
    init(profileView: UIView, profileGenerator: ProfileGenerator) {
        
        self.profileGenerator = profileGenerator
        super.init(frame: profileView.frame)
        
        profileView.addSubview(self)
        self.setupView(with: profileView)
    }
    
    private func setupView(with: UIView){
        
        // Set up constraints
        self.translatesAutoresizingMaskIntoConstraints = false
        let profileView = with
        NSLayoutConstraint.activate([
            self.topAnchor.constraint(equalTo: profileView.topAnchor),
            self.bottomAnchor.constraint(equalTo: profileView.bottomAnchor),
            self.leadingAnchor.constraint(equalTo: profileView.leadingAnchor),
            self.trailingAnchor.constraint(equalTo: profileView.trailingAnchor),
        ])
        
        // Create the gradient layer
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [UIColor.black.cgColor, UIColor.clear.cgColor]
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 1.0)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 0.4)
        gradientLayer.frame = self.bounds

        // Add the gradient layer as a sublayer
        self.layer.addSublayer(gradientLayer)
        self.contentMode = .scaleAspectFill
        self.image = UIImage(named: "Image")
    }
    
    public override func didChangeValue(forKey key: String) {
        if (key == "Profile Dismissed"){
            self.configure(with: self.profileGenerator.getNextProfile())
        }
    }
    
    public func configure(with: [String: Any]){
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
