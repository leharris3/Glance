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
    
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var topProfile: UIView!
    
    var startingX: Float = 0.0
    var startingY: Float = 0.0

    var relativeX: Float = 0
    var relativeY: Float = 0
    
    var maxHeight: Float = 0.0
    var minHeight: Float = 0.0
    
    var screenWidth = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set max height and width.
        maxHeight = Float(topProfile.frame.origin.y + 20)
        minHeight = Float(topProfile.frame.origin.y - 40)
        
        // Set starting coords.
        startingX = Float(topProfile.frame.origin.x)
        startingY = Float(topProfile.frame.origin.y)
        
        
        screenWidth = Int(view.bounds.width)

    }
}

extension FeatureViewController {

    // TODO: double tap recognizer
    
    // if view is tapped:
        // move view a max of 10 pixels up or down
        // horizontal movement is unrestricted
        // if horizontal movement exceeds threshold left or right:
            // tint view color red
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        guard let touch = touches.first else {
            return
        }
        
        let location = touch.location(in: topProfile)
        let absoluteLocation = touch.location(in: view)
        
        // Set relative coords.
        relativeX = Float(absoluteLocation.x)
        relativeY = Float(absoluteLocation.y)
        
        if (topProfile.bounds.contains(location)) {
            isDragging = true
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard isDragging, let touch = touches.first else {
            return
        }
        
        let location = touch.location(in: view)
        
        // Set new X.
        topProfile.frame.origin.x += location.x - CGFloat(relativeX)
        
        let candidateHeight: Float = Float(topProfile.frame.origin.y + location.y - CGFloat(relativeY))
        
        // Set new Y.
        if (candidateHeight > maxHeight) {
            topProfile.frame.origin.y = CGFloat(maxHeight)
        }
        else if (candidateHeight < minHeight) {
            topProfile.frame.origin.y = CGFloat(minHeight)
        }
        else {
            topProfile.frame.origin.y = CGFloat(candidateHeight)
        }
        
        // Set relative coords.
        relativeX = Float(Int(location.x))
        relativeY = Float(Int(location.y))
        
        let distance = abs(view.frame.midX - topProfile.frame.midX) // Calculate distance from origin.
        let ratio = Float(distance) / Float((screenWidth / 2)) // % moved towards a horizontal edge.
        
        topProfile.alpha = 1 - ( CGFloat(ratio) * (1 / 2)  )
        
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        // MARK: Recenter Profile.
        while (topProfile.frame.origin.x != 
            topProfile.frame.origin.x  CGFloat(startingX)
        topProfile.frame.origin.y = CGFloat(startingY)
        topProfile.alpha = 1
        
        
        // TODO: Dismiss right.
        
        // TODO: Dismiss left.
    }
    
}
