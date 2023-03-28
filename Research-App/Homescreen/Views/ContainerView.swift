//
//  ContainerView.swift
//  Research-App
//
//  Created by Levi Harris on 3/28/23.
//

import UIKit

class ContainerView: UIView {

    init(vc: UIViewController) {
        
        super.init(frame: vc.view.bounds)
        
        self.translatesAutoresizingMaskIntoConstraints = false
        self.backgroundColor = .systemBlue
        vc.view.addSubview(self)
        
        let margins = vc.view.safeAreaLayoutGuide
        
        let constraints = [
            self.leftAnchor.constraint(equalTo: margins.leftAnchor, constant: 0.0),
            self.rightAnchor.constraint(equalTo: margins.rightAnchor, constant: 0.0),
            self.topAnchor.constraint(equalTo: margins.topAnchor, constant: 0.0),
            self.bottomAnchor.constraint(equalTo: margins.bottomAnchor, constant: 0.0)
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
