//
//  User.swift
//  TWClone
//
//  Created by RafaelAsencio on 03/12/2020.
//

import UIKit

struct User {
    let uid: String
    let profileImage: String
    let email: String
    let fullname: String
    let username: String
    
    init(uid: String, dictionary: [String: AnyObject]) {
        self.uid = uid
        self.profileImage = dictionary["profileImageUrl"] as? String ?? ""
        self.email = dictionary["email"] as? String ?? ""
        self.fullname = dictionary["fullname"] as? String ?? ""
        self.username = dictionary["username"] as? String ?? ""
    }
}
