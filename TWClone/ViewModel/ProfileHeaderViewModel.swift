//
//  ProfileHeaderViewModel.swift
//  TWClone
//
//  Created by RafaelAsencio on 06/12/2020.
//

import UIKit

enum ProfileFilterOptions: Int, CaseIterable {
    case tweets
    case replies
    case likes
    
    var description: String {
        switch self {
        case .tweets: return "Tweets"
        case .replies: return "Replies"
        case .likes: return "Likes"
        }
    }
}

struct ProfileHeaderViewModel {
    
    //MARK: - Properties
    private let user: User
    
    let usernameText: String
    
    var followersString: NSAttributedString? {
        return self.attributedText(withValue: self.user.stats?.following ?? 0, text: "followers")
    }
    
    var followingString: NSAttributedString? {
        return self.attributedText(withValue: self.user.stats?.followers ?? 0, text: "following")
    }
    
    var actionButtonTitle: String {
        if user.isCurrentUser {
            return "Edit Profile"
        }
        if  !user.isFollowed && !self.user.isCurrentUser {
            return "Follow"
        }
        if user.isFollowed {
            return "Following"
        }
        return "Loading"
    }
    
    //MARK: - Init
    init(user: User) {
        self.user = user
        self.usernameText = "@" + user.username
    }
    
    //MARK: - Functions
    private func attributedText(withValue value: Int, text: String)-> NSAttributedString {
        let attributedTitle = NSMutableAttributedString(string: "\(value)", attributes: [.font : UIFont.boldSystemFont(ofSize: 14)])
        attributedTitle.append(NSAttributedString(string: " \(text)", attributes: [.font : UIFont.systemFont(ofSize: 14),
                                                                                  .foregroundColor: UIColor.lightGray]))
        return attributedTitle
    }
}
