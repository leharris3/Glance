//
//  FeatureViewController.swift
//  Research-App
//
//  Created by Levi Harris on 2/25/23.
//

import UIKit
import SwiftUI

class FeatureViewController: UIViewController {

    @IBOutlet weak var contentView: UIView!
    
    @IBOutlet weak var profileImageOneView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        contentView.layer.cornerRadius = 30
        
        GlobalConstants.db.collection("user-info").document("Test").setData([ "first_name": "Levi"], merge: true)
    }
}
