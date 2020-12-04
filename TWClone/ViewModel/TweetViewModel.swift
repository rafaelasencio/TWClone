//
//  TweetViewModel.swift
//  TWClone
//
//  Created by RafaelAsencio on 04/12/2020.
//

import UIKit

struct TweetViewModel {
    
    //MARK: - Properties
    let tweet: Tweet
    let user: User
    
    var profileImageUrl: URL? {
        return tweet.user.profileImageURL
    }
    
    var userInfoText: NSAttributedString {
        let title = NSMutableAttributedString(string: user.fullname, attributes:
                                                [.font : UIFont.boldSystemFont(ofSize: 14)])
        title.append(NSAttributedString(string: " @\(user.username)", attributes:
                                            [ .font: UIFont.systemFont(ofSize: 14),
                                              .foregroundColor: UIColor.lightGray]))
        title.append(NSAttributedString(string: " ・\(timeStamp)", attributes: [.font: UIFont.systemFont(ofSize: 14),
                                                                        .foregroundColor: UIColor.lightGray]))
        return title
    }
    
    var timeStamp: String {
        let formatted = DateComponentsFormatter()
        formatted.allowedUnits = [.second, .minute, .hour, .day, .weekOfMonth, .month]
        formatted.maximumUnitCount = 1
        formatted.unitsStyle = .abbreviated
        let now = Date()
        return formatted.string(from: tweet.timeStamp, to: now) ?? "1m"
    }
    
    init(tweet: Tweet) {
        self.tweet = tweet
        self.user = tweet.user
    }
}
