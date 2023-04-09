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
    private var database: Database
    private var images: [Data]
    
    init(profileView: UIView) {
    
        self.profileGenerator = ProfileGenerator.getProfileGenerator()
        self.database = Database.getDatabase()
        self.images = []
        super.init(frame: profileView.frame)
        
        profileView.addSubview(self)
        self.setupView(with: profileView)
    }
    
    private func setupView(with: UIView){
        
        // Set up constraints
        self.layer.cornerRadius = 15
        self.clipsToBounds = true
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
        let images = self.profileGenerator.getNextProfile()
        self.image = UIImage(named: "Image")
    }
    
    public override func didChangeValue(forKey key: String) {
        if (key == "Profile Dismissed"){
            if let email = self.profileGenerator.getNextProfile() {
                self.configure(with: email)
            }
        }
    }
    
    public func configure(with: String?){
        let email: String = with ?? ""
        if let imagesArray = database.getUserField(email: email, field: "photos") as? [Data] {
            self.images = imagesArray
            self.image = UIImage(data: images[0])
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
