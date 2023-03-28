//
//  TopProfileView.swift
//  Research-App
//
//  Created by Levi Harris on 3/28/23.
//

import UIKit

class TopProfileView: UIView {

    init(vc: UIViewController, container: UIView) {
        
        super.init(frame: vc.view.bounds)
        
        self.translatesAutoresizingMaskIntoConstraints = false
        self.backgroundColor = .red
        self.clipsToBounds = true
        container.addSubview(self)
        
        let constraints = [
            self.topAnchor.constraint(equalTo: container.topAnchor, constant: 10.0),
            self.bottomAnchor.constraint(equalTo: container.bottomAnchor, constant: -65.0),
            self.leftAnchor.constraint(equalTo: container.leftAnchor, constant: 10.0),
            self.rightAnchor.constraint(equalTo: container.rightAnchor, constant: -10.0)
        ]
        NSLayoutConstraint.activate(constraints)
        
        self.layer.cornerRadius = 20
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
