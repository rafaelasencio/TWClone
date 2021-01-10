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
    
    var usernameText: String {
        return "@\(user.username)"
    }
    
    var headerTimeStamp: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "h:mm a · MM/dd/yyyy"
        return formatter.string(from: tweet.timeStamp)
    }
    
    var retweetAttributedString: NSAttributedString? {
        return attributedText(withValue: tweet.retweetCount, text: "Retweets")
    }
    
    var likesAttributedString: NSAttributedString? {
        return attributedText(withValue: tweet.likes, text: "Likes")
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
    
    private func attributedText(withValue value: Int, text: String)-> NSAttributedString {
        let attributedTitle = NSMutableAttributedString(string: "\(value)", attributes: [.font : UIFont.boldSystemFont(ofSize: 14)])
        attributedTitle.append(NSAttributedString(string: " \(text)", attributes: [.font : UIFont.systemFont(ofSize: 14),
                                                                                  .foregroundColor: UIColor.lightGray]))
        return attributedTitle
    }
}
