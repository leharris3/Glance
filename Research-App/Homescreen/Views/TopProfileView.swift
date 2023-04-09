//
//  TopProfileView.swift
//  Research-App
//
//  Created by Levi Harris on 3/28/23.
//

import UIKit
import SwiftUI

class TopProfileView: UIView {
    
    private var observers: [UIView]
    private var startingPoint: CGPoint?
    private var tapGestureRecognizer: UIPanGestureRecognizer!
    private var profileGenerator: ProfileGenerator!
    private var infoButton: UIButton!
    private var profileImage: ProfileImage?

    init(vc: UIViewController, container: UIView) {
        
        self.observers = []
        self.profileGenerator = ProfileGenerator.getProfileGenerator()
        self.infoButton = UIButton()
        self.profileImage = nil
        super.init(frame: vc.view.bounds)
        
        print("------------------------------------------------------------")
        print("Initializing top profile view.")
        
        // Add to container.
        container.addSubview(self)
        
        // Set up constraints
        NSLayoutConstraint.activate([
            topAnchor.constraint(equalTo: container.topAnchor, constant: 5.0),
            bottomAnchor.constraint(equalTo: container.bottomAnchor, constant: -65.0),
            leftAnchor.constraint(equalTo: container.leftAnchor, constant: 10.0),
            rightAnchor.constraint(equalTo: container.rightAnchor, constant: -10.0)
        ])
        
        tapGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        container.addGestureRecognizer(tapGestureRecognizer)
        
        self.profileImage = ProfileImage(profileView: self)
        self.setupView()
        self.addObserver(view: self.profileImage!)
        self.profileImage!.configure(with: self.profileGenerator.getCurrentProfile())
    }
    
    private func setupView() {
        
        backgroundColor = .white
        layer.cornerRadius = 15
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.3
        layer.shadowOffset = CGSize(width: 0, height: 0)
        layer.shadowRadius = 3
        
        translatesAutoresizingMaskIntoConstraints = false
        isUserInteractionEnabled = true
        clipsToBounds = false
        
        // Create and add the info button
        let infoButton = UIButton()
        infoButton.translatesAutoresizingMaskIntoConstraints = false
        let infoImage = UIImage(systemName: "info", withConfiguration: UIImage.SymbolConfiguration(pointSize: 30, weight: .black))?.withTintColor(.white, renderingMode: .alwaysOriginal)
        infoButton.setImage(infoImage, for: .normal)
        infoButton.alpha = 1.0
        infoButton.isUserInteractionEnabled = true
        self.addSubview(infoButton)
        NSLayoutConstraint.activate([
            infoButton.widthAnchor.constraint(equalToConstant: 40),
            infoButton.heightAnchor.constraint(equalToConstant: 40),
            infoButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -20),
            infoButton.trailingAnchor.constraint(equalTo: self .trailingAnchor, constant: -10),
        ])
        
        // Add action for info button tap event
        infoButton.addTarget(self, action: #selector(infoButtonTapped), for: .touchUpInside)
        self.infoButton = infoButton
    }
    
    public override func didChangeValue(forKey key: String) {
        if (key == "Description is Visible") {
            self.tapGestureRecognizer.isEnabled = false

        }
        if (key == "Description is Invisible") {
            self.tapGestureRecognizer.isEnabled = true
        }
    }
    
    public func addObserver(view: UIView) {
        self.observers.append(view)
    }

    private func swiped() {
        
    }

    private func dismissProfile() {
        self.profileGenerator?.pop()
        if let email = profileGenerator.getCurrentProfile() {
            self.configure(with: email)
        }
        for observer in observers {
            observer.didChangeValue(forKey: "Profile Dismissed")
        }
    }
    
    public func configure(with: String) {}
    
    @objc func handleTap(_ sender: UIPanGestureRecognizer) {
        switch sender.state {
        case .began:
            startingPoint = center
            UIView.animate(withDuration: 0.3) {
                self.infoButton.alpha = 0.0
            }
        case .changed:
            guard let startingPoint = startingPoint else { return }
            let translation = sender.translation(in: superview)
            let horizontalDisplacement = min(max(-50.0, translation.x), 50.0)
            center = CGPoint(x: startingPoint.x + translation.x, y: startingPoint.y + translation.y)
            let angle = horizontalDisplacement / 1000.00 // Adjust the angle based on your preference
            let transform = CGAffineTransform(rotationAngle: angle)
            self.transform = transform
        case .ended:
            guard let startingPoint = startingPoint else { return }
            let translation = sender.translation(in: superview)
            let horizontalDisplacement = min(max(-50.0, translation.x), 50.0)
            let direction: CGFloat = horizontalDisplacement < 0 ? -1 : 1
            let screenWidth = UIScreen.main.bounds.width
            let swipeThreshold = screenWidth * 0.5 // adjust threshold based on desired swipe distance
            let swipeDistance = abs(translation.x)
            let finalCenter: CGPoint
            let finalTransform: CGAffineTransform
            if swipeDistance >= swipeThreshold {
                let finalX = direction * screenWidth * 2.0 // adjust multiplier based on desired distance
                finalCenter = CGPoint(x: finalX, y: startingPoint.y + translation.y)
                finalTransform = CGAffineTransform(rotationAngle: direction * .pi / 8)
                self.swiped()
            } else {
                finalCenter = startingPoint
                finalTransform = .identity
            }
            UIView.animate(withDuration: 0.3) {
                self.center = finalCenter
                self.transform = finalTransform
            } completion: { _ in
                self.transform = .identity
                if swipeDistance >= swipeThreshold {
                    self.dismissProfile()
                }
                UIView.animate(withDuration: 0.0, delay: 0.5) {
                    self.center = startingPoint
                } completion: { _ in
                    UIView.animate(withDuration: 0.3) {
                        self.infoButton.alpha = 1.0
                    }
                }
            }
        default:
            break
        }
    }

    @objc private func infoButtonTapped() {
        for observer in observers {
            observer.didChangeValue(forKey: "Show Description")
        }
        self.tapGestureRecognizer.isEnabled = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
