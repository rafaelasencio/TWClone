//
//  TweetCell.swift
//  TWClone
//
//  Created by RafaelAsencio on 03/12/2020.
//

import UIKit

class TweetCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .twitterBlue
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
