//
//  FeatureViewController.swift
//  Research-App
//
//  Created by Levi Harris on 2/25/23.
//

import UIKit
import SwiftUI

class FeatureViewController: UIViewController {
    
    // TODO: Batch profile loading.
        // On inital load
    
    // Scroll profile description.
    @IBOutlet weak var profileDescriptionScrollView: UIScrollView!
    
    // Height of profile description scroll view.
    @IBOutlet weak var profileDescriptionHeightConstraint: NSLayoutConstraint!
    
    private var scrollViewHeightVisable: NSLayoutConstraint? = nil
    private var scrollViewHeightInvisible: NSLayoutConstraint? = nil
    
    // Show more button.
    @IBOutlet weak var showMoreButton: UIButton!
    
    // Hide description.
    @IBOutlet weak var hideDescriptionButton: UIButton!
    
    // Touch handling.
    private var isDragging: Bool = false
    
    // Profile swiping disabled on description display.
    private var swipingIsEnabled: Bool = true
    
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
        
        initializeVariables()
        loadProfileBatch()
    }
    
    private func loadProfileBatch(){
        return
    }
    
    private func initializeVariables() {
        
        // Initalize constraints.
        scrollViewHeightVisable = profileDescriptionHeightConstraint
        scrollViewHeightInvisible = profileDescriptionHeightConstraint.constraintWithMultiplier(0.0)
        
        // Set var to inital value.
        profileDescriptionScrollView.removeConstraint(profileDescriptionHeightConstraint!)
        profileDescriptionScrollView.addConstraint(scrollViewHeightInvisible!)
        view.layoutIfNeeded()
        
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
        
        // Set a thin border
        profileDescriptionScrollView.layer.borderWidth = 1
        profileDescriptionScrollView.layer.borderColor = UIColor.darkGray.cgColor
        
        // Hide description disabled by default.
        hideDescriptionButton.alpha = 0.0
        hideDescriptionButton.isUserInteractionEnabled = false

    }
    
    private func loadNewProfileView(view: UIView) {
        let colors: [UIColor] = [.systemBlue, .systemRed, .systemPink, .systemRed, .systemMint, .darkGray, .magenta]
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
        
        UIView.animate(withDuration: 0.15, delay: 0.0, animations: {
            self.topProfile.frame.origin.x = CGFloat(self.startingX)
            self.topProfile.frame.origin.y = CGFloat(self.startingY)
        })
    }
    
    // Swap top and bottom profiles, load a new profile.
    func swapProfiles () {
        topProfile.backgroundColor = bottomProfile.backgroundColor
        loadNewProfileView(view: bottomProfile)
    }
    
    // Show description.
    @IBAction func showMorePressed(_ sender: Any) {
        swipingIsEnabled = false
        profileDescriptionScrollView.removeConstraint(scrollViewHeightInvisible!)
        profileDescriptionScrollView.addConstraint(scrollViewHeightVisable!)
        UIView.animate(withDuration: 0.15, delay: 0.0, animations: {
            self.view.layoutIfNeeded()
            self.showMoreButton.alpha = 0.0
            self.showMoreButton.isUserInteractionEnabled = false
            self.hideDescriptionButton.alpha = 1.0
            self.hideDescriptionButton.isUserInteractionEnabled = true
        })
    }
    
    // Hide description.
    @IBAction func hideDescriptionPressed(_ sender: Any) {
        print("pressed")
        swipingIsEnabled = true
        profileDescriptionScrollView.removeConstraint(scrollViewHeightVisable!)
        profileDescriptionScrollView.addConstraint(scrollViewHeightInvisible!)
        UIView.animate(withDuration: 0.15, delay: 0.0, animations: {
            self.view.layoutIfNeeded()
            self.showMoreButton.alpha = 1.0
            self.showMoreButton.isUserInteractionEnabled = true
            self.hideDescriptionButton.alpha = 0.0
            self.hideDescriptionButton.isUserInteractionEnabled = false
        })
    }
    
}

extension NSLayoutConstraint {
    func constraintWithMultiplier(_ multiplier: CGFloat) -> NSLayoutConstraint {
        return NSLayoutConstraint(item: self.firstItem!, attribute: self.firstAttribute, relatedBy: self.relation, toItem: self.secondItem, attribute: self.secondAttribute, multiplier: multiplier, constant: self.constant)
    }
}

extension FeatureViewController {

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        if !(swipingIsEnabled) {return}
        
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
        
        if !(swipingIsEnabled) {return}
        
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
        
        if !(swipingIsEnabled) {return}
        
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
                    UIView.animate(withDuration: 0.2, delay: 0.0, animations: {
                        self.topProfile.frame.origin.x -= distanceToMaxEdge
                    }, completion: {(finished: Bool) in
                        self.swapProfiles()
                        self.topProfile.frame.origin.x = self.startingX
                        self.topProfile.frame.origin.y = self.startingY
                    })
                }
                else {
                    UIView.animate(withDuration: 0.2, delay: 0.0, animations: {
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
    
