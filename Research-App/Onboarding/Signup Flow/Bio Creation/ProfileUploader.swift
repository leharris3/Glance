import Foundation
import FirebaseStorage
import FirebaseCore
import FirebaseFirestore

class ProfileUploader: NSObject {
    
    private var db: Firestore
    private var storage: Storage
    private var profile: [String: Any]
    private var photos: [UIImage]
    
    override init() {
        
        self.db = Firestore.firestore()
        self.storage = Storage.storage()
        self.profile = [:]
        self.photos = []
        super.init()
        
        let email = GlobalConstants.email ?? ""
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
        
        self.profile = [
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
            "photos": photos
        ]
        
    }
    
    public func upload() -> Bool {
        let sex = (profile["sex"] as! String) ?? ""
        let email: String = (profile["email"] ?? "") as! String
        
        let ref = db.collection("profiles").document(email) // use email as the document ID
        ref.setData(profile) // set data with custom document ID
        
        self.addUserToPool(sex: sex as! String, email: email as! String)
        return true
    }
    
    
    private func addUserToPool(sex: String, email: String) {
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
    
