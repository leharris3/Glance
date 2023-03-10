//
//  BioDescriptionViewController.swift
//  Research-App
//
//  Created by Levi Harris on 3/10/23.
//

import UIKit
import FirebaseStorage

class BioPhotosViewController: UIViewController {
    
    @IBOutlet weak var uploadMedia: UIButton!
    
    var selectedImage: UIImage?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func uploadPhotos() {
        
        guard selectedImage != nil else {
            return
        }
        
        let storageRef = Storage.storage().reference()
        let imageData = selectedImage!.jpegData(compressionQuality: 0.8)
        guard imageData != nil else {
            return
        }
        let fileRef = storageRef.child("images/\(UUID().uuidString).jpg")
        let uploadTask = fileRef.putData(imageData!, metadata: nil) {metadata, error in
            if error == nil && metadata != nil {
                 
            }
        }
    }
    
    @IBAction func uploadMedia(_ sender: Any) {
        uploadPhotos()
    }
    
}
