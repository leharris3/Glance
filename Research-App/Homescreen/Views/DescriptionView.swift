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
    
    private var observers: [UIView]
    private var profileGenerator: ProfileGenerator?
    private var scrollView: UIScrollView!
    private var nameAgeLabel: UILabel!
    private var interestsLabel: UILabel!
    private var bioLabel: UILabel!
    private var closeButton: UIButton!
    
    init(vc: UIViewController, container: UIView) {
        
        self.observers = []
        self.nameAgeLabel = UILabel()
        self.interestsLabel = UILabel()
        self.bioLabel = UILabel()
        self.profileGenerator = ProfileGenerator.getProfileGenerator()
        
        super.init(frame: vc.view.bounds)
        
        self.translatesAutoresizingMaskIntoConstraints = false
        self.backgroundColor = .white
        self.layer.cornerRadius = 15
        self.layer.borderWidth = 2.0
        self.layer.borderColor = UIColor.black.cgColor
        self.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
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
        
        self.setupFields()
    }
    
    // Add the fields to the scroll view
    private func setupFields() {
        
        // Create the scroll view
        self.alpha = 1.0
        self.scrollView = UIScrollView()
        self.scrollView.translatesAutoresizingMaskIntoConstraints = false
        self.scrollView.isUserInteractionEnabled = true
        self.scrollView.clipsToBounds = true
        self.addSubview(self.scrollView)

        NSLayoutConstraint.activate([
            self.scrollView.topAnchor.constraint(equalTo: self.topAnchor),
            self.scrollView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.scrollView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.scrollView.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.size.height/4.0)
        ])

        let closeButton = UIButton(type: .custom)
        closeButton.setImage(UIImage(systemName: "xmark"), for: .normal)
        closeButton.tintColor = .black
        closeButton.translatesAutoresizingMaskIntoConstraints = false
        self.scrollView.addSubview(closeButton)
        
        NSLayoutConstraint.activate([
        closeButton.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
        closeButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
        closeButton.widthAnchor.constraint(equalToConstant: 30),
        closeButton.heightAnchor.constraint(equalToConstant: 30)
        ])
        
        closeButton.addTarget(self, action: #selector(closeButtonTapped), for: .touchUpInside)
        self.closeButton = closeButton
        
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
        bioLabel.text = "Biography: Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla gravida sapien at purus vestibulum tincidunt. Donec in aliquam nibh. Quisque vel sapien commodo, vestibulum ligula in, tristique tellus. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla gravida sapien at purus vestibulum tincidunt. Donec in aliquam nibh. Quisque vel sapien commodo, vestibulum ligula in, tristique tellus."
        bioLabel.numberOfLines = 0
        self.scrollView.addSubview(bioLabel)
        
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
        
        nameAgeLabel.font = UIFont(name: "Futura-Bold", size: 24.0)
        interestsLabel.font = UIFont(name: "Futura", size: 16.0)
        bioLabel.font = UIFont(name: "Futura", size: 16.0)
        
        self.nameAgeLabel = nameAgeLabel
        self.interestsLabel = interestsLabel
        self.bioLabel = bioLabel
        self.configure(with: (profileGenerator?.getCurrentProfile()) ?? "")
    }
    
    @objc private func closeButtonTapped() {
        self.hide()
    }

    public func addObserver(view: UIView) {
        self.observers.append(view)
    }
    
    public func notifyObservers(with: String) {
        print(self.observers)
        for observer in self.observers {
            observer.didChangeValue(forKey: with)
        }
    }
    
    override func didChangeValue(forKey key: String) {
        
        if (key == "Profile Dismissed"){
            if let email = self.profileGenerator!.getNextProfile() {
                self.configure(with: email)
            }
        }
        else if (key == "Show Description") {
            self.show()
        }
    }
    
    public func configure(with: String) {
        let db = Database.getDatabase()
        if let email = profileGenerator?.getCurrentProfile() {
            let name = (db.getUserField(email: email, field: "first_name") as! String) ?? ""
            let age = String(db.getUserField(email: email, field: "age") as! Int) ?? ""
            nameAgeLabel.text = name + " " + age
            
            var i = 0
            var interests = "Interests: "
            var interestsArr = (db.getUserField(email: email, field: "interests")) as! [String]
            while(i < interestsArr.count) {
                if (i == interestsArr.count - 1){
                    interests += interestsArr[i]
                }
                else {
                    interests = interests + interestsArr[i] +  ", "
                }
                i += 1
            }
            interestsLabel.text = interests
            
            var bio = (db.getUserField(email: email, field: "bio") as? String) ?? ""
            bioLabel.text = bio
        }
    }
    
    private func show() {
        UIView.animate(withDuration: 0.0) {
            self.alpha = 1.0
            self.isUserInteractionEnabled = true
            self.removeConstraint(self.heightConstraint!)
            self.heightAnchor.constraint(equalToConstant: 200.0).isActive = true
            self.layoutIfNeeded()
        }
        self.notifyObservers(with: "Description is Visible")
    }
    
    private func hide() {
        UIView.animate(withDuration: 0.0) {
            self.alpha = 0.0
            self.isUserInteractionEnabled = false
            self.removeConstraint(self.heightConstraint!)
            self.heightAnchor.constraint(equalToConstant: 0.0).isActive = true
            self.layoutIfNeeded()
        }
        self.notifyObservers(with: "Description is Invisible")
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
	
