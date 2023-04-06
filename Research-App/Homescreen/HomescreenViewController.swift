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
        self.initializeHomescreen()
    }
    
    private func initializeHomescreen() {
        
        view.backgroundColor = .white
        
        navigationItem.title = "Muse"
        navigationController?.navigationBar.titleTextAttributes = [
            NSAttributedString.Key.font: UIFont(descriptor: UIFontDescriptor(name: "Optima-Bold", size: 30).withSymbolicTraits(.traitBold)!, size: 30),
            NSAttributedString.Key.foregroundColor: UIColor.black
        ]

        let containerView = ContainerView(vc: self)
        self.view.addSubview(containerView)
        
        // Create a profile generator.
        let profileGenerator = ProfileGenerator()
        
        let bottomProfileView = BottomProfileView(vc: self, container: containerView, profileGenerator: profileGenerator)
        let topProfileView = TopProfileView(vc: self, container: containerView, profileGenerator: profileGenerator)
        
        let descriptionView = DescriptionView(vc: self, container: containerView, profileGenerator: profileGenerator)
        let toolbar = ToolbarView(vc: self, container: containerView)
        
        // Set up tap gesture recognizer
        let tapGesture = UIPanGestureRecognizer(target: topProfileView, action: #selector(topProfileView.handleTap(_:)))
        topProfileView.addGestureRecognizer(tapGesture)
        
        topProfileView.addObserver(view: bottomProfileView)
        topProfileView.addObserver(view: descriptionView)
    }
}
