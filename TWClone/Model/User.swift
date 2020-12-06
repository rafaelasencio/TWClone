//
//  User.swift
//  TWClone
//
//  Created by RafaelAsencio on 03/12/2020.
//

import UIKit
import Firebase

struct User {
    let uid: String
    var profileImageURL: URL?
    let email: String
    let fullname: String
    let username: String
    
    var isCurrentUser: Bool {
        return Auth.auth().currentUser?.uid == self.uid
    }
    
    init(uid: String, dictionary: [String: AnyObject]) {
        self.uid = uid
        self.email = dictionary["email"] as? String ?? ""
        self.fullname = dictionary["fullname"] as? String ?? ""
        self.username = dictionary["username"] as? String ?? ""
        
        if let profileImageURL = dictionary["profileImageUrl"] as? String {
            guard let url =  URL(string: profileImageURL) else { return }
            self.profileImageURL = url
        }
        
    }
}
