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
        
        // Database.
        let db = Firestore.firestore()
//        db.collection("user-profiles").addDocument(data: "example-user")
//        db.collection("user-profiles").document("example-user")

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
        let unseenProfiles: [String] = []
        let likedProfiles: [String] = []
        let photo_urls: [String] = []
        
        let profileDictionary: [String: Any] = [
            "email": email,
            "first_name": firstName,
            "dob": dob,
            "age": age,
            "sex": sex,
            "preference": preference,
            "interests": interests,
            "liked_profiles": likedProfiles,
            "about_me": "",
            "matches": matches,
            "seen_profiles": seenProfiles,
            "unseen_profiles": unseenProfiles,
            "photo_urls": photo_urls
        ]
        
        // Reference to user profile in cloud store.
        let ref = db.collection("users").document("user-profiles")
        
        // Upload profile.
        ref.setData([email: profileDictionary], merge: true)
        
        // Add user to user pool.
        UploadProfile.addUserToPool(db: db, sex: sex, email: email)
        
        // Empty photo list 
        if (photos.count == 0){ return false}
        
        // Upload photos
        for photo in GlobalConstants.user.profilePhotos {
            UploadProfile.uploadPhoto(data: photo, email: email)
        }
        
        return true // MARK: Profile successfully uploaded.
    }
    
    // Upload a photo.
    static func uploadPhoto(data: Data, email: String){
        
        let db = Firestore.firestore()
        
        // Create Storage Ref.
        let storage = Storage.storage()
        let storageRef = storage.reference()
        
        // Create references to cloud store.
        let ref = storageRef.child("images/\(String(describing: GlobalConstants.email))/\(UUID().uuidString)")
        let profileRef = db.collection("users").document("user-profiles").updateData([:])

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
    
    static func addUserToPool(db: Firestore, sex: String, email: String) {
        
        var tempArray: [Any] = []
        let ref = db.collection("users").document("user-lists")
        ref.getDocument { (document, error) in
            if (error != nil) {
                print("Error adding user to user pools")
                return }
            if ((document?.exists) != nil) {
                if (sex == "M"){
                    // Add male user to user pool.
                    tempArray = document!.get("male-users") as! [Any]
                    tempArray.append(email)
                    db.collection("users").document("user-lists").setData(["male-users": tempArray], merge: true)
                    print("Male Added to User-Pool.")
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
    }
}
