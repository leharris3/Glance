//
//  HomescreenViewController.swift
//  Research-App
//
//  Created by Levi Harris on 3/27/23.
//

import UIKit

class HomescreenViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.initializeHomescreen()
    }
    
    private func initializeHomescreen() {
        
        view.backgroundColor = .white
        
        navigationItem.title = "Muse"
        navigationController?.navigationBar.titleTextAttributes = [
            NSAttributedString.Key.font: UIFont(name: "Optima-Bold", size: 35)!,
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
        
        topProfileView.addObserver(view: bottomProfileView)
        topProfileView.addObserver(view: descriptionView)
        descriptionView.addObserver(view: topProfileView)
    }
}
