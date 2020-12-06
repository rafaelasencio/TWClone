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
    
    var followersString: NSAttributedString? {
        return self.attributedText(withValue: 0, text: "followers")
    }
    
    var followingString: NSAttributedString? {
        return self.attributedText(withValue: 2, text: "following")
    }
    
    //MARK: - Init
    init(user: User) {
        self.user = user
    }
    
    //MARK: - Functions
    private func attributedText(withValue value: Int, text: String)-> NSAttributedString {
        let attributedTitle = NSMutableAttributedString(string: "\(value)", attributes: [.font : UIFont.boldSystemFont(ofSize: 14)])
        attributedTitle.append(NSAttributedString(string: " \(text)", attributes: [.font : UIFont.systemFont(ofSize: 14),
                                                                                  .foregroundColor: UIColor.lightGray]))
        return attributedTitle
    }
}
