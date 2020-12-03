//
//  TweetService.swift
//  TWClone
//
//  Created by RafaelAsencio on 03/12/2020.
//

import UIKit
import Firebase

class TweetService {
    
    static let shared = TweetService()
    
    func uploadTweet(caption: String, completion: @escaping(Error?, DatabaseReference)->()){
        guard let uid = Auth.auth().currentUser?.uid else { return }
        let timestamp = NSDate().timeIntervalSince1970
        let values = ["uid":uid,
                      "timestamp":timestamp,
                      "likes":0,
                      "retweets":0,
                      "caption":caption] as [String: AnyObject]
        //childByAutoId generate a uuid
        TWEETS_REF.childByAutoId().updateChildValues(values, withCompletionBlock: completion)
    }
    
}
