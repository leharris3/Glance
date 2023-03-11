//
//  Upload User Card.swift
//  Research-App
//
//  Created by Levi Harris on 3/11/23.
//

import Foundation
import FirebaseStorage
import FirebaseCore
import FirebaseFirestore

class UploadProfile: NSObject {
    
    // Uploads all info in user card.
    static func uploadProfile() -> Bool {
        
        let db = Firestore.firestore()

        let photos: [Data?] =  GlobalConstants.user.profilePhotos
        let email: String = GlobalConstants.email! // Should never be nil.
        let firstName: String = GlobalConstants.user.firstName!
        let dob: Date = GlobalConstants.user.dateOfBirth!
        let age: Int = GlobalConstants.user.age
        let sex: String = GlobalConstants.user.sex
        let preference: String = GlobalConstants.user.preference
        let interests: [String] = GlobalConstants.user.interests
        
        // Upload first name.
        db.collection("user-info").document(email).setData(["first_name": firstName], merge: true)
        // Upload dOB.
        db.collection("user-info").document(email).setData(["dob": dob], merge: true)
        // Upload age.
        db.collection("user-info").document(email).setData(["age": age], merge: true)
        // Upload sex.
        db.collection("user-info").document(email).setData(["sex": sex], merge: true)
        // Upload preference.
        db.collection("user-info").document(email).setData(["preference": preference], merge: true)
        // Upload interests.
        db.collection("user-info").document(email).setData(["interests": interests], merge: true)
        
        // Empty photo list
        if (photos.count == 0){ return false}
        
        // Upload photos
        for photo in GlobalConstants.user.profilePhotos {
            UploadProfile.uploadPhoto(data: photo)
        }
        
        return true // MARK: Profile successfully uploaded.
    }
    
    // Upload a photo.
    static func uploadPhoto(data: Data){
        // Create Storage Ref.
        let storage = Storage.storage()
        let storageRef = storage.reference()
        
        let ref = storageRef.child("images/\(String(describing: GlobalConstants.email))/\(UUID().uuidString)")

        // Upload the file.
        let uploadTask = ref.putData(data, metadata: nil) { (metadata, error) in
          guard let metadata = metadata else {
            return
          }
          // Metadata.
          let size = metadata.size
          ref.downloadURL { (url, error) in
            guard let downloadURL = url else {
              return
            }
          }
        }
    }
}
