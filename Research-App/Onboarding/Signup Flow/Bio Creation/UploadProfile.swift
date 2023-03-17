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
        let matches: [String] = []
        let seenProfiles: [String] = []
        
        let profileDictionary: [String: Any] = [
            "email": email,
            "first_name": firstName,
            "dob": dob,
            "age": age,
            "sex": sex,
            "preference": preference,
            "interests": interests,
            "matches": matches,
            "seen_profiles": seenProfiles
        ]
        
        // Upload profile.
        db.collection("users").document("user-profiles").setData([email: profileDictionary], merge: true)
        
        var tempArray: [Any] = []
        
        let ref = db.collection("users").document("user-lists")
        ref.getDocument { (document, error) in
            if (error != nil) { return }
            if ((document?.exists) != nil) {
                if (sex == "M"){
                    // Add male user to user pool.
                    tempArray = document!.get("male-users") as! [Any]
                    tempArray.append(email)
                    db.collection("users").document("user-lists").setData(["male-users": tempArray], merge: true)
                }
                else if (sex == "W"){
                    // Add female user to user pool.
                    tempArray = document!.get("female-users") as! [Any]
                    tempArray.append(email)
                    db.collection("users").document("user-lists").setData(["female-users": tempArray], merge: true)
                }
                else {
                    // Non-binary user added to both pools.
                    tempArray = document!.get("male-users") as! [Any]
                    tempArray.append(email)
                    db.collection("users").document("user-lists").setData(["male-users": tempArray], merge: true)
                    
                    tempArray = document!.get("female-users") as! [Any]
                    tempArray.append(email)
                    db.collection("users").document("user-lists").setData(["female-users": tempArray], merge: true)
                }   
                
                // Add new profile to all users pool.
                tempArray = document!.get("all-users") as! [Any]
                tempArray.append(email)
                db.collection("users").document("user-lists").setData(["all-users": tempArray], merge: true)
            }
            else { return }
        }
        
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
