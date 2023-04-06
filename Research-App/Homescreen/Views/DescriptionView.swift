//
//  DESCR.swift
//  Research-App
//
//  Created by Levi Harris on 3/28/23.
//

import Foundation

import UIKit

//  DESCR.swift
//  Research-App
//
//  Created by Levi Harris on 3/28/23.
//

import UIKit

class DescriptionView: UIView {
    
    var profileGenerator: ProfileGenerator?
    var scrollView: UIScrollView!
    var nameAgeLabel: UILabel!
    var interestsLabel: UILabel!
    var bioLabel: UILabel!
    
    init(vc: UIViewController, container: UIView, profileGenerator: ProfileGenerator) {
        
        self.nameAgeLabel = UILabel()
        self.interestsLabel = UILabel()
        self.bioLabel = UILabel()
        
        super.init(frame: vc.view.bounds)
        self.profileGenerator = profileGenerator
        
        self.translatesAutoresizingMaskIntoConstraints = false
        self.backgroundColor = .white
        self.layer.cornerRadius = 15
        self.layer.borderWidth = 2.0
        self.layer.borderColor = UIColor.black.cgColor
        self.translatesAutoresizingMaskIntoConstraints = false
        self.isUserInteractionEnabled = true
        self.clipsToBounds = true
        
        container.addSubview(self)
        let constraints = [
            self.bottomAnchor.constraint(equalTo: container.bottomAnchor, constant: -65.0),
            self.leftAnchor.constraint(equalTo: container.leftAnchor, constant: 10.0),
            self.rightAnchor.constraint(equalTo: container.rightAnchor, constant: -10.0),
            self.heightAnchor.constraint(equalToConstant: 0.0)
        ]
        NSLayoutConstraint.activate(constraints)
        
        self.alpha = 1.0
        self.profileGenerator = profileGenerator
        
        // Create the scroll view
        self.scrollView = UIScrollView()
        self.scrollView.translatesAutoresizingMaskIntoConstraints = false
        self.scrollView.isUserInteractionEnabled = true
        self.scrollView.clipsToBounds = false
        self.addSubview(self.scrollView)
        NSLayoutConstraint.activate([
            self.scrollView.topAnchor.constraint(equalTo: self.topAnchor),
            self.scrollView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.scrollView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.scrollView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
        
        self.setUpFields()
    }
    
    // Add the fields to the scroll view
    private func setUpFields() {
        let nameAgeLabel = UILabel()
        nameAgeLabel.translatesAutoresizingMaskIntoConstraints = false
        nameAgeLabel.text = "Chris F. 27"
        self.scrollView.addSubview(nameAgeLabel)

        let interestsLabel = UILabel()
        interestsLabel.translatesAutoresizingMaskIntoConstraints = false
        interestsLabel.text = "Interests: Hiking, Reading"
        self.scrollView.addSubview(interestsLabel)

        let dividingLine = UIView()
        dividingLine.translatesAutoresizingMaskIntoConstraints = false
        dividingLine.backgroundColor = UIColor.gray
        self.scrollView.addSubview(dividingLine)

        let bioLabel = UILabel()
        bioLabel.translatesAutoresizingMaskIntoConstraints = false
        bioLabel.text = "Biography: Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla gravida sapien at purus vestibulum tincidunt. Donec in aliquam nibh. Quisque vel sapien commodo, vestibulum ligula in, tristique tellus."
        bioLabel.numberOfLines = 0
        self.scrollView.addSubview(bioLabel)

        // Set fonts and styles.
        nameAgeLabel.font = UIFont.boldSystemFont(ofSize: 18.0)
        interestsLabel.font = UIFont.systemFont(ofSize: 16.0)
        bioLabel.font = UIFont.systemFont(ofSize: 16.0)

        // Add constraints for the fields
        NSLayoutConstraint.activate([
            nameAgeLabel.topAnchor.constraint(equalTo: self.scrollView.topAnchor, constant: 10.0),
            nameAgeLabel.leadingAnchor.constraint(equalTo: self.scrollView.leadingAnchor, constant: 10.0),

            interestsLabel.topAnchor.constraint(equalTo: nameAgeLabel.bottomAnchor, constant: 0.0),
            interestsLabel.leadingAnchor.constraint(equalTo: self.scrollView.leadingAnchor, constant: 10.0),

            dividingLine.topAnchor.constraint(equalTo: interestsLabel.bottomAnchor, constant: 7.5),
            dividingLine.leadingAnchor.constraint(equalTo: self.scrollView.leadingAnchor),
            dividingLine.trailingAnchor.constraint(equalTo: self.scrollView.trailingAnchor),
            dividingLine.heightAnchor.constraint(equalToConstant: 1.0),

            bioLabel.topAnchor.constraint(equalTo: dividingLine.bottomAnchor, constant: 10.0),
            bioLabel.leadingAnchor.constraint(equalTo: self.scrollView.leadingAnchor, constant: 10.0),
            bioLabel.trailingAnchor.constraint(equalTo: self.scrollView.trailingAnchor, constant: -10.0),
            bioLabel.bottomAnchor.constraint(equalTo: self.scrollView.bottomAnchor, constant: -10.0),
            bioLabel.widthAnchor.constraint(equalTo: self.scrollView.widthAnchor, constant: -20.0)
        ])

        nameAgeLabel.font = UIFont(name: "Optima-Bold", size: 24.0)
        interestsLabel.font = UIFont(name: "Optima", size: 16.0)
        bioLabel.font = UIFont(name: "Optima", size: 16.0)
        
        self.nameAgeLabel = nameAgeLabel
        self.interestsLabel = interestsLabel
        self.bioLabel = bioLabel
        
        let downArrowButton = UIButton()
        downArrowButton.translatesAutoresizingMaskIntoConstraints = false
        let downArrowImage = UIImage(systemName: "info", withConfiguration: UIImage.SymbolConfiguration(pointSize: 40, weight: .regular))?.withTintColor(.white, renderingMode: .alwaysOriginal)
        downArrowButton.setImage(downArrowImage, for: .normal)
        self.addSubview(downArrowButton)
        NSLayoutConstraint.activate([
            downArrowButton.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            downArrowButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -400.00),
            downArrowButton.widthAnchor.constraint(equalToConstant: 50.0),
            downArrowButton.heightAnchor.constraint(equalToConstant: 50.0)
        ])
    }
    
    public func configure(with: [String: Any]) {
        
    }
    
    private func show() {
        UIView.animate(withDuration: 0.5) {
            self.alpha = 1.0
            self.isUserInteractionEnabled = true
            self.removeConstraint(self.heightConstraint!)
            self.heightAnchor.constraint(equalToConstant: 200.0).isActive = true
            self.layoutIfNeeded()
        }
    }
    
    private func hide() {
        UIView.animate(withDuration: 0.5) {
            self.alpha = 0.0
            self.isUserInteractionEnabled = false
            self.removeConstraint(self.heightConstraint!)
            self.heightAnchor.constraint(equalToConstant: 0.0).isActive = true
            self.layoutIfNeeded()
        }
    }

    override func didChangeValue(forKey key: String) {
        
        if (key == "Profile Dismissed"){
            self.configure(with: self.profileGenerator!.getNextProfile())
        }
        else if (key == "Show Description") {
            self.show()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
