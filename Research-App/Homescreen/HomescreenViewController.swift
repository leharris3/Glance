//
//  HomescreenViewController.swift
//  Research-App
//
//  Created by Levi Harris on 3/27/23.
//

import UIKit

class HomescreenViewController: UIViewController {
    
    override func viewDidLoad() {
        
        // Loading Order
            // 1. Load profile datasets
            // 2. Pass profiles to a view constructor
            // Who controls auto re-loading of profiles?
        
        super.viewDidLoad()
        initializeHomescreen()
    }
    
    private func initializeHomescreen() {
        
        view.backgroundColor = .white
        
        let containerView = ContainerView(vc: self)
        self.view.addSubview(containerView)
        
        let topProfileView = TopProfileView(vc: self, container: containerView)
        let toolbar = ToolbarView(vc: self, container: containerView)
        
        // Set up tap gesture recognizer
        let tapGesture = UIPanGestureRecognizer(target: topProfileView, action: #selector(topProfileView.handleTap(_:)))
        topProfileView.addGestureRecognizer(tapGesture)
    }
}
