//
//  AuthService.swift
//  TWClone
//
//  Created by RafaelAsencio on 03/12/2020.
//

import UIKit
import Firebase

struct AuthCredentials {
    let profileImage: UIImage
    let email: String
    let password: String
    let fullname: String
    let username: String
}

class AuthService {
    
    static let shared = AuthService()
    
    func registerUser(_ user: AuthCredentials, completion: @escaping(Error?, DatabaseReference)->()){
        //Create user
        Auth.auth().createUser(withEmail: user.email, password: user.password) { (result, error) in
            if let error = error {
                print("DEBUG: error "+error.localizedDescription)
                return
            }
            //Upload photo to Storage
            let imageName = UUID().uuidString
            let metadata = StorageMetadata()
            metadata.contentType = "image/jpeg"
            guard let imageJPG = user.profileImage.jpegData(compressionQuality: 0.3) else { return }

            STORAGE_PROFILE_IMAGES.child(imageName).putData(imageJPG, metadata: metadata) { (meta, error) in
                if let error = error {
                    print("DEBUG: error "+error.localizedDescription)
                    return
                }
                print("DEBUG: user profile image uploaded")
                //Get profileImage URL
                STORAGE_PROFILE_IMAGES.child(imageName).downloadURL { (url, error) in
                    guard let profileImageUrl = url?.absoluteString else { return }
                    let values = ["email": user.email,
                                  "fullname": user.fullname,
                                  "username": user.username,
                                  "profileImageUrl": profileImageUrl]
                    //Upload values into the Database
                    guard let uid = result?.user.uid else { return }
                    USER_REF.child(uid).updateChildValues(values, withCompletionBlock: completion)
                }
            }
            print("DEBUG: user created")
        }
    }
}
