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
    
    func uploadTweet(caption: String, type: UploadTweetConfiguration, completion: @escaping(Error?, DatabaseReference)->()){
        guard let uid = Auth.auth().currentUser?.uid else { return }
        let timestamp = NSDate().timeIntervalSince1970
        let values = ["uid":uid,
                      "timestamp":timestamp,
                      "likes":0,
                      "retweets":0,
                      "caption":caption] as [String: AnyObject]
        switch type {
        case .tweet:
            TWEETS_REF.childByAutoId().updateChildValues(values) { (error, ref) in
                //update user_tweet structure after tweet upload completes
                guard let tweetID = ref.key else { return }
                USER_TWEETS_REF.child(uid).updateChildValues([tweetID: 1], withCompletionBlock: completion)
            }
        case .reply(let tweet):
            TWEET_REPLIES_REF.child(tweet.tweetId).childByAutoId().updateChildValues(values, withCompletionBlock: completion)
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
