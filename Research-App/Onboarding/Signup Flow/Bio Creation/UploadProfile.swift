import Foundation
import FirebaseStorage
import FirebaseCore
import FirebaseFirestore

class UploadProfile {
    
    static let db = Firestore.firestore()
    static let storage = Storage.storage()
    static var photo_urls = [String]()
    
    static func uploadProfile() -> Bool {
        guard let email = GlobalConstants.email else {return false}
        let user = GlobalConstants.user
        
        let photos = user.profilePhotos
        let firstName = user.firstName ?? ""
        let dob = user.dateOfBirth ?? Date()
        let age = user.age
        let sex = user.sex
        let preference = user.preference
        let interests = user.interests
        let matches = [String]()
        let seenProfiles = [String]()
        let unseenProfiles = [String]()
        let likedProfiles = [String]()
    
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
        let ref = db.collection("users").document(email)
        
        // Upload profile.
        ref.setData(profileDictionary, merge: true)
        
        // Add user to user pool.
        addUserToPool(sex: sex, email: email)
        
        // Empty photo list
        if photos.count == 0 { return false}
        
        // Upload photos
        for photo in photos {
            uploadPhoto(data: photo, email: email)
        }
        
        return true
    }
    
    // Upload a photo.
    static func uploadPhoto(data: Data?, email: String) {
        guard let data = data else { return }
        
        // Create references to cloud store.
        let storageRef = storage.reference().child("images/\(email)/\(UUID().uuidString)")
        
        // Upload the file.
        let uploadTask = storageRef.putData(data, metadata: nil) { (metadata, error) in
            guard let metadata = metadata else { return }
            // Metadata.
            let size = metadata.size
            storageRef.downloadURL { (url, error) in
                guard let downloadURL = url else { return }
                photo_urls.append(downloadURL.absoluteString)
                print(downloadURL.absoluteString)
            }
        }
    }
    
    static func addUserToPool(sex: String, email: String) {
        let ref = db.collection("users").document("user-lists")
        
        ref.getDocument { (document, error) in
            if let document = document {
                var maleUsers = document.get("male-users") as? [String] ?? [String]()
                var femaleUsers = document.get("female-users") as? [String] ?? [String]()
                var allUsers = document.get("all-users") as? [String] ?? [String]()
                
                if sex == "M" {
                    maleUsers.append(email)
                } else if sex == "W" {
                    femaleUsers.append(email)
                } else {
                    maleUsers.append(email)
                    femaleUsers.append(email)
                }
                
                allUsers.append(email)
                
                let data: [String: Any] = [
                    "male-users": maleUsers,
                    "female-users": femaleUsers,
                    "all-users": allUsers
                ]
                
                ref.setData(data, merge: true)
            }
        }
    }
}
    
