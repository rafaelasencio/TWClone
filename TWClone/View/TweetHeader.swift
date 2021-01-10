//
//  TweetHeader.swift
//  TWClone
//
//  Created by RafaelAsencio on 09/01/2021.
//

import UIKit

class TweetHeader: UICollectionReusableView {
    
    //MARK: - Properties
    private lazy var profileImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.setDimensions(width: 48, height: 48)
        iv.layer.cornerRadius = 48 / 2
        iv.backgroundColor = .twitterBlue
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleProfileImageTapped))
        iv.addGestureRecognizer(tap)
        iv.isUserInteractionEnabled = true
        return iv
    }()
    
    private let fullnameLabel: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont.boldSystemFont(ofSize: 14)
        lbl.text = "fullnameLabel"
        return lbl
    }()
    
    private let usernameLabel: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont.systemFont(ofSize: 14)
        lbl.textColor = .lightGray
        lbl.text = "usernameLabel"
        return lbl
    }()
    
    private let captionLabel: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont.systemFont(ofSize: 20)
        lbl.numberOfLines = 0
        lbl.text = "caption textcaption textcaption textcaption textcaption text"
        return lbl
    }()
    
    private let dateLabel: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont.systemFont(ofSize: 14)
        lbl.textColor = .lightGray
        lbl.textAlignment = .left
        lbl.text = "6:00 PM - 9/01/2021"
        return lbl
    }()
    
    private lazy var optionButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.tintColor = .lightGray
        btn.setImage(UIImage(named: "down_arrow_24pt"), for: .normal)
        btn.addTarget(self, action: #selector(showActionSheet), for: .touchUpInside)
        return btn
    }()
    
    private let retweetsLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "2 Retweets"
        return lbl
    }()
    
    private let likesLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "0 Likes"
        return lbl
    }()
    
    private lazy var statsView: UIView = {
        let v = UIView()
//        v.backgroundColor = .red
        
        let divider1 = UIView()
        divider1.backgroundColor = .systemGroupedBackground
        v.addSubview(divider1)
        divider1.anchor(top: v.topAnchor, left: v.leftAnchor, right: v.rightAnchor, paddingLeft: 8, height: 1.0)
        
        let stack = UIStackView(arrangedSubviews: [retweetsLabel, likesLabel])
        stack.axis = .horizontal
        stack.spacing = 12
        v.addSubview(stack)
        
        stack.centerY(inView: v)
        stack.anchor(left: v.leftAnchor, paddingLeft: 16)
        
        let divider2 = UIView()
        divider2.backgroundColor = .systemGroupedBackground
        v.addSubview(divider2)
        divider2.anchor(left: v.leftAnchor, bottom: v.bottomAnchor, right: v.rightAnchor, paddingLeft: 8, height: 1.0)
        
        return v
    }()
    
    private lazy var commentButton: UIButton = {
        let btn = createButton(withImageName: "comment")
        btn.addTarget(self, action: #selector(handleCommentTapped), for: .touchUpInside)
        return btn
    }()
    
    private lazy var retweetButton: UIButton = {
        let btn = createButton(withImageName: "retweet")
        btn.addTarget(self, action: #selector(handleRetweetTapped), for: .touchUpInside)
        return btn
    }()
    
    private lazy var likeButton: UIButton = {
        let btn = createButton(withImageName: "like")
        btn.addTarget(self, action: #selector(handleLikeTapped), for: .touchUpInside)
        return btn
    }()
    
    private lazy var shareButton: UIButton = {
        let btn = createButton(withImageName: "share")
        btn.addTarget(self, action: #selector(handleShareTapped), for: .touchUpInside)
        return btn
    }()
    
    //MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let labelStack = UIStackView(arrangedSubviews: [fullnameLabel, usernameLabel])
        labelStack.axis = .vertical
        labelStack.spacing = -6
        
        let stack = UIStackView(arrangedSubviews: [profileImageView, labelStack])
        stack.spacing = 12
        addSubview(stack)
        stack.anchor(top: topAnchor, left: leftAnchor, paddingTop: 16, paddingLeft: 16)
        
        addSubview(captionLabel)
        captionLabel.anchor(top: stack.bottomAnchor, left: leftAnchor, right: rightAnchor, paddingTop: 20, paddingLeft: 16, paddingRight: 16)
        
        addSubview(dateLabel)
        dateLabel.anchor(top: captionLabel.bottomAnchor, left: leftAnchor, paddingTop: 10, paddingLeft: 16)
        
        addSubview(optionButton)
        optionButton.centerY(inView: stack)
        optionButton.anchor(right: rightAnchor, paddingRight: 8)
        
        addSubview(statsView)
        statsView.anchor(top: dateLabel.bottomAnchor, left: leftAnchor, right: rightAnchor, paddingTop: 10, height: 40)
        
        let actionStack = UIStackView(arrangedSubviews: [commentButton, retweetButton, likeButton, shareButton])
        actionStack.spacing = 72

        addSubview(actionStack)
        actionStack.centerX(inView: self)
        actionStack.anchor(bottom: bottomAnchor, paddingBottom: 12)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Selectors
    @objc func handleProfileImageTapped(){
        print("DEBUG: go to user profile")
    }
    
    @objc func showActionSheet(){
        print("DEBUG: handle show action")
    }
    
    @objc func handleCommentTapped(){
        print("DEBUG: handleCommentTapped")
    }
    
    @objc func handleRetweetTapped(){
        print("DEBUG: handleRetweetTapped")
    }
    
    @objc func handleLikeTapped(){
        print("DEBUG: handleLikeTapped")
    }
    
    @objc func handleShareTapped(){
        print("DEBUG: handleShareTapped")
    }
    
    //MARK: - Helpers
    func createButton(withImageName imageName: String)-> UIButton{
        let btn = UIButton(type: .system)
        btn.setImage(UIImage(named: imageName), for: .normal)
        btn.tintColor = .darkGray
        btn.setDimensions(width: 20, height: 20)
        return btn
    }
}
