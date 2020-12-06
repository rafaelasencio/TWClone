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
