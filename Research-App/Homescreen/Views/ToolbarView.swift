//
//  ToolbarView.swift
//  Research-App
//
//  Created by Levi Harris on 3/28/23.
//

import Foundation
import UIKit

class ToolbarView: UIToolbar {

    init(vc: UIViewController, container: UIView) {
        
        super.init(frame: vc.view.bounds)
        
        self.translatesAutoresizingMaskIntoConstraints = false
        self.backgroundColor = .yellow
        container.addSubview(self)
        
        let constraints = [
            self.bottomAnchor.constraint(equalTo: container.bottomAnchor, constant: 0.0),
            self.leftAnchor.constraint(equalTo: container.leftAnchor, constant: 0.0),
            self.rightAnchor.constraint(equalTo: container.rightAnchor, constant: 0.0),
            self.heightAnchor.constraint(equalToConstant: 50.0)
        ]
        NSLayoutConstraint.activate(constraints)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

