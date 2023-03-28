//
//  HomescreenViewController.swift
//  Research-App
//
//  Created by Levi Harris on 3/27/23.
//

import UIKit

class HomescreenViewController: UIViewController {
    
    var user: Any? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initializeHomescreen()
    }
    
    private func initializeHomescreen() {
        
        view.backgroundColor = .white
        
        let containerView = ContainerView(vc: self)
        self.view.addSubview(containerView)
        
        let topProfileView = TopProfileView(vc: self, container: containerView)
        let descriptionView = DescriptionView(vc: self, container: topProfileView)
        let toolbar = ToolbarView(vc: self, container: containerView)
    }
}
