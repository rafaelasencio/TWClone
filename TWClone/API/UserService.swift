//
//  UserService.swift
//  TWClone
//
//  Created by RafaelAsencio on 03/12/2020.
//

import Foundation
import Firebase

class UserService {
    
    static let shared = UserService()
    
    func fetchUser(withUID uid: String, completion:@escaping(User)->()){
        USER_REF.child(uid).observeSingleEvent(of: .value) { (snapshot) in
            guard let dictionary = snapshot.value as? [String: AnyObject] else { return }
            let user = User(uid: uid, dictionary: dictionary)
            completion(user)
        }
    }
    
    func fetchUsers(completion:@escaping([User])->()){
        var users: [User] = []
        USER_REF.observe(.childAdded) { (snapshot) in
            let uid = snapshot.key
            guard let dictionary = snapshot.value as? [String: AnyObject] else { return }
            let user = User(uid: uid, dictionary: dictionary)
            users.append(user)
            completion(users)
        }
    }
}
