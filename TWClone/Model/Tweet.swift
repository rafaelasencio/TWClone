//
//  Tweet.swift
//  TWClone
//
//  Created by RafaelAsencio on 03/12/2020.
//

import UIKit

struct Tweet {
    let caption: String
    let tweetId: String
    let uid: String
    let likes: Int
    var timeStamp: Date!
    let retweetCount: Int
    
    init(tweetId: String, dictionary: [String: Any]) {
        self.tweetId = tweetId
        self.caption = dictionary["caption"] as? String ?? ""
        self.uid = dictionary["uid"] as? String ?? ""
        self.likes = dictionary["likes"] as? Int ?? 0
        self.retweetCount = dictionary["retweetCount"] as? Int ?? 0
        
        if let timeStamp = dictionary["timestamp"] as? Double {
            self.timeStamp = Date(timeIntervalSince1970: timeStamp)
        }
    }
}
