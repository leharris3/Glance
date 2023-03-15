//
//  FeatureViewController.swift
//  Research-App
//
//  Created by Levi Harris on 2/25/23.
//

import UIKit
import SwiftUI

class FeatureViewController: UIViewController {

    private var isDragging: Bool = false
    
    // All profiles viewed in a session.
    private var seenProfiles: [String] = []
    
    private var loadedProfiles: [String] = []
    
    // Images assoicated w/ a profile.
    private var topProfilesImages: [UIImage] = []
    private var bottomProfileImages: [UIImage] = []
    
    // Container.
    @IBOutlet weak var contentView: UIView!
    
    // Profiles.
    @IBOutlet weak var topProfile: UIView!
    @IBOutlet weak var bottomProfile: UIView!
    
    // Bio scroll view.
    @IBOutlet weak var bioScrollView: UIScrollView!
    
    // Starting constants.
    var profileBounds: CGRect? = nil
    
    var startingX: CGFloat = 0.0
    var startingY: CGFloat = 0.0

    var relativeX: CGFloat = 0
    var relativeY: CGFloat = 0
    
    var maxHeight: CGFloat = 0.0
    var minHeight: CGFloat = 0.0
    
    var maxWidth: CGFloat = 0.0
    var minWidth: CGFloat = 0.0
    
    var deltaX: CGFloat = 0.0
    var deltaY: CGFloat = 0.0
    
    var screenWidth: CGFloat = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set generic profileBounds.
        profileBounds = topProfile.bounds
        
        // Load new profiles
        loadNewProfileView(view: topProfile)
        loadNewProfileView(view: bottomProfile)
        
        // Interaction w/ bottom profile disabled by default.
        bottomProfile.isUserInteractionEnabled = false
        
        topProfile.layer.cornerRadius = 30
        bottomProfile.layer.cornerRadius = 30
        // bioScrollView.layer.cornerRadius = 30
        
        // Set max height and width.
        maxHeight = topProfile.frame.origin.y + 30
        minHeight = topProfile.frame.origin.y - 20
        
        maxWidth = topProfile.frame.midX + 100.00
        minWidth = topProfile.frame.midX - 100.00
        
        // Set starting coords.
        startingX = topProfile.frame.origin.x
        startingY = topProfile.frame.origin.y
        
        // Total screen width.
        screenWidth = view.bounds.width
    }
    
    // TODO: Profile object creation, batch loading, dynamic profile generation.
    private func importProfileBatch() {
        
    }
    
    private func loadNewProfileView(view: UIView) {
        let colors: [UIColor] = [.systemBlue, .systemRed, .systemPink, .systemRed, .systemMint]
        view.backgroundColor = colors.randomElement()
    }
    
    func setOrigin(x: CGFloat, y: CGFloat) {
        topProfile.frame
        topProfile.frame.origin.y = y
    }
    
    // Return profile to center of screen.
    func returnToCenter() {
        
        let distanceX: CGFloat = CGFloat(startingX) - topProfile.frame.origin.x
        let distanceY: CGFloat = CGFloat(startingY) - topProfile.frame.origin.y
        
        UIView.animate(withDuration: 0.25, delay: 0.0, animations: {
            self.topProfile.frame.origin.x = CGFloat(self.startingX)
            self.topProfile.frame.origin.y = CGFloat(self.startingY)
        })
    }
    
    // Swap top and bottom profiles, load a new profile.
    func swapProfiles () {
        topProfile.backgroundColor = bottomProfile.backgroundColor
        loadNewProfileView(view: bottomProfile)
    }
}

extension FeatureViewController {

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        guard let touch = touches.first else {
            return
        }
        
        let location = touch.location(in: topProfile)
        let absoluteLocation = touch.location(in: view)
        
        // Set relative coords.
        relativeX = absoluteLocation.x
        relativeY = absoluteLocation.y
        
        if (topProfile.bounds.contains(location)) {
            isDragging = true
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        // Prev coords.
        let prevX = topProfile.frame.origin.x
        let prevY = topProfile.frame.origin.y
        
        guard isDragging, let touch = touches.first else {
            return
        }
        
        // Location.
        let location = touch.location(in: view)
        
        // Set new X.
        topProfile.frame.origin.x += location.x - CGFloat(relativeX)
        
        let candidateHeight: CGFloat = topProfile.frame.origin.y + location.y - relativeY
        
        // Set new Y.
        if (candidateHeight > maxHeight) {
            topProfile.frame.origin.y = maxHeight
        }
        else if (candidateHeight < minHeight) {
            topProfile.frame.origin.y = minHeight
        }
        else {
            topProfile.frame.origin.y = candidateHeight
        }
        
        // New coords.
        let newX = topProfile.frame.origin.x
        let newY = topProfile.frame.origin.y
        
        // Set deltas.
        deltaX = newX - prevX
        deltaY = newY - prevY
        
        // Set relative coords.
        relativeX = location.x
        relativeY = location.y
        
        let distance = abs(view.frame.midX - topProfile.frame.midX) // Calculate distance from origin.
        let ratio = distance / (screenWidth / 2) // % moved towards a horizontal edge.
        
        // topProfile.alpha = 1 - ( CGFloat(ratio) * (1 / 2)  )
        
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        // TODO: Single Tap Gesture Recognizer
            // Change picture.
            // If a touch begins and ends on the same coordinate, it is considered a tap.
        
        // TODO: Double Tap Gesture Recognizer
            // Like animation and prompt.
            // On touch begins,
        
        // TODO: Bio popup on swipe up.
        
        // TODO: Bio close on close button.
        
        // Calculate velocity of swipe.
        let velocityX: CGFloat = deltaX
        let velocityY: CGFloat = deltaY
        let directionIndependentVelocity: CGFloat = hypot(velocityX, velocityY)
        
        let distanceToMaxEdge = self.topProfile.bounds.maxX
        let distanceToMinEdge = self.maxWidth - self.topProfile.bounds.minX
        
        // print(directionIndependentVelocity)

        // MARK: Dismiss
        if (topProfile.frame.midX < minWidth || topProfile.frame.midX > maxWidth) {
            
            if (directionIndependentVelocity > 2.5) {
                // print("Swipe out")
                
                // Swipe out left / right
                if (velocityX < 0) {
                    // Swipe right
                    UIView.animate(withDuration: 0.5, delay: 0.0, animations: {
                        self.topProfile.frame.origin.x -= distanceToMaxEdge
                    }, completion: {(finished: Bool) in
                        self.swapProfiles()
                        self.topProfile.frame.origin.x = self.startingX
                        self.topProfile.frame.origin.y = self.startingY
                    })
                }
                else {
                    UIView.animate(withDuration: 0.5, delay: 0.0, animations: {
                        self.topProfile.frame.origin.x += distanceToMinEdge
                    }, completion: {(finished: Bool) in
                        self.swapProfiles()
                        self.topProfile.frame.origin.x = self.startingX
                        self.topProfile.frame.origin.y = self.startingY
                    })
                }
            }
            else {
                returnToCenter()
            }
        }
        else {
            returnToCenter()
        }
    }
}
