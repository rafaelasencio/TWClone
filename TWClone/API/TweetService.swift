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
        let ref = TWEETS_REF.childByAutoId()
        //childByAutoId generate a uuid
//        TWEETS_REF.childByAutoId().updateChildValues(values, withCompletionBlock: completion)
        ref.updateChildValues(values) { (error, ref) in
            guard let tweetID = ref.key else { return }
            USER_TWEETS_REF.child(uid).updateChildValues([tweetID: 1], withCompletionBlock: completion)
        }
    }
    
    func fetchTweets(completion:@escaping([Tweet])->()){
        var tweets = [Tweet]()
        
        TWEETS_REF.observe(.childAdded) { snapshot in
            guard let dictionary = snapshot.value as? [String: Any] else { return }
            guard let uid = dictionary["uid"] as? String else { return }
            let tweetId = snapshot.key
            
            UserService.shared.fetchUser(withUID: uid) { user in
                let tweet = Tweet(user: user, tweetId: tweetId, dictionary: dictionary)
                tweets.append(tweet)
                completion(tweets)
            }
        }
    }
    
    func fetchTweets(forUser user: User, completion: @escaping([Tweet]?)->()){
        var tweets = [Tweet]()
        USER_TWEETS_REF.child(user.uid).observe(.childAdded) { snapshot in
            print(snapshot)
            let tweetId = snapshot.key
            TWEETS_REF.child(tweetId).observeSingleEvent(of: .value) { snapshot in
                guard let dictionary = snapshot.value as? [String: Any] else { return }
                guard let uid = dictionary["uid"] as? String else { return }
                UserService.shared.fetchUser(withUID: uid) { user in
                    let tweet = Tweet(user: user, tweetId: tweetId, dictionary: dictionary)
                    tweets.append(tweet)
                    completion(tweets)
                }
            }
        }
    }
}
