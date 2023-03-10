//
//  BioDescriptionViewController.swift
//  Research-App
//
//  Created by Levi Harris on 3/10/23.
//

import UIKit
import FirebaseStorage
import YPImagePicker

class BioPhotosViewController: UIViewController {
    
    @IBOutlet weak var uploadMedia: UIButton!
    
    var selectedImage: UIImage?

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // Firebase Image Upload
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
        // uploadPhotos()
        let picker = YPImagePicker()
        picker.didFinishPicking { [unowned picker] items, _ in
            if let photo = items.singlePhoto {
                print(photo.fromCamera) // Image source (camera or library)
                print(photo.image) // Final image selected by the user
                print(photo.originalImage) // original image selected by the user, unfiltered
                print(photo.modifiedImage) // Transformed image, can be nil
                print(photo.exifMeta) // Print exif meta data of original image.
            }
            picker.dismiss(animated: true, completion: nil)
        }
        present(picker, animated: true, completion: nil)
    }
    
}
