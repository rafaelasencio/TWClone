//
//  UserService.swift
//  TWClone
//
//  Created by RafaelAsencio on 03/12/2020.
//

import Foundation
import Firebase

typealias DatabaseCompletion = (Error?, DatabaseReference)->()

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
    
    func followUser(uid: String, completion: @escaping(DatabaseCompletion)){
        guard let currentUid = Auth.auth().currentUser?.uid else { return }
        USER_FOLLOWING_REF.child(currentUid).updateChildValues([uid: 1]) { (error, ref) in
            print("DEBUG: currentUid\(currentUid), ref.key\(ref.key ?? "")")
            USER_FOLLOWERS_REF.child(uid).updateChildValues([currentUid:1], withCompletionBlock: completion)
        }
    }
    
    func unfollowUser(uid: String, completion: @escaping(DatabaseCompletion)){
        guard let currentUid = Auth.auth().currentUser?.uid else { return }
        USER_FOLLOWING_REF.child(currentUid).child(uid).removeValue { (error, ref) in
            USER_FOLLOWERS_REF.child(uid).child(currentUid).removeValue(completionBlock: completion)
        }
    }
    
    func checkIfUserIsFollowed(uid: String, completion: @escaping(Bool)->()){
        guard let currentUid = Auth.auth().currentUser?.uid else { return }
        USER_FOLLOWING_REF.child(currentUid).child(uid).observeSingleEvent(of: .value) { (snapshot) in
            completion(snapshot.exists())
        }
    }
    
    func fetchUserStats(uid: String, completion: @escaping(UserRelationStats)->()){
        USER_FOLLOWERS_REF.child(uid).observeSingleEvent(of: .value) { (snapshot) in
            let followers = snapshot.children.allObjects.count
            
            USER_FOLLOWING_REF.child(uid).observeSingleEvent(of: .value) { (snapshot) in
                let following = snapshot.children.allObjects.count
                let stats = UserRelationStats(followers: followers, following: following)
                completion(stats)
            }
        }
    }
}
