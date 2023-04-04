//
//  TopProfileView.swift
//  Research-App
//
//  Created by Levi Harris on 3/28/23.
//

import UIKit
import SwiftUI

class TopProfileView: UIView {

    private var startingPoint: CGPoint?
    private var tapGestureRecognizer: UITapGestureRecognizer!

    init(vc: UIViewController, container: UIView) {
        super.init(frame: vc.view.bounds)
        
        // Set up the view
        backgroundColor = .white
        layer.cornerRadius = 20
        layer.borderWidth = 5.0
        layer.borderColor = UIColor.black.cgColor
        layer.shadowColor = UIColor.systemRed.cgColor
        layer.shadowOpacity = 1.0
        layer.shadowOffset = CGSize(width: 5, height: 5)
        layer.shadowRadius = 0
        clipsToBounds = false
        translatesAutoresizingMaskIntoConstraints = false
        container.addSubview(self)
        
        // Set up constraints
        NSLayoutConstraint.activate([
            topAnchor.constraint(equalTo: container.topAnchor, constant: 10.0),
            bottomAnchor.constraint(equalTo: container.bottomAnchor, constant: -65.0),
            leftAnchor.constraint(equalTo: container.leftAnchor, constant: 10.0),
            rightAnchor.constraint(equalTo: container.rightAnchor, constant: -10.0)
        ])
        
        // Enable user interaction
        isUserInteractionEnabled = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func handleTap(_ sender: UIPanGestureRecognizer) {
        switch sender.state {
            case .began:
                startingPoint = center
                superview?.bringSubviewToFront(self)
            case .changed:
                guard let startingPoint = startingPoint else { return }
                let translation = sender.translation(in: superview)
                let horizontalDisplacement = min(max(-50.0, translation.x), 50.0)
                center = CGPoint(x: startingPoint.x + translation.x, y: startingPoint.y + translation.y)
            let angle = horizontalDisplacement / 800.00 // Adjust the angle based on your preference
                let transform = CGAffineTransform(rotationAngle: angle)
                self.transform = transform
            case .ended:
                guard let startingPoint = startingPoint else { return }
                UIView.animate(withDuration: 0.15) {
                    self.center = startingPoint
                    self.transform = .identity
                }
            default:
                break
            }
    }
}
