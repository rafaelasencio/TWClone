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
    
    func fetchUser(){
        guard let uid = Auth.auth().currentUser?.uid else { return }
        USER_REF.child(uid).observeSingleEvent(of: .value) { (snapshot) in
            guard let dictionary = snapshot.value as? [String: AnyObject] else { return }
            let user = User(uid: uid, dictionary: dictionary)
        }
    }
}
