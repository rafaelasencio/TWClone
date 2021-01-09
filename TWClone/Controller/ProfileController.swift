//
//  ProfileController.swift
//  TWClone
//
//  Created by RafaelAsencio on 05/12/2020.
//

import UIKit

private let identifier = "TweetCell"
private let headerIdentifier = "ProfileHeader"
class ProfileController: UICollectionViewController {
    
    //MARK: - Properties
    private var user: User
    
    private var tweets = [Tweet]() {
        didSet {
            collectionView.reloadData()
        }
    }
    
    //MARK: - Lifecycle
    init(user: User) {
        self.user = user
        super.init(collectionViewLayout: UICollectionViewFlowLayout())
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureCollectionView()
        self.fetchTweets()
        self.checkIfUserIsFollowed()
        self.fetchUserStats()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.barStyle = .black
        navigationController?.navigationBar.isHidden = true
    }
    
    //MARK: - Helpers
    
    private func configureCollectionView(){
        collectionView.backgroundColor = .white
        collectionView.contentInsetAdjustmentBehavior = .never //cover header till top
        collectionView.register(TweetCell.self, forCellWithReuseIdentifier: identifier)
        collectionView.register(ProfileHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerIdentifier)
    }
    
    //MARK: - API
    
    private func fetchTweets(){
        TweetService.shared.fetchTweets(forUser: self.user) { tweets in
            guard let tweets = tweets else { return }
            self.tweets = tweets
        }
    }
    
    private func checkIfUserIsFollowed(){
        UserService.shared.checkIfUserIsFollowed(uid: user.uid) { (isFollowed) in
            print("DEBUG: \(isFollowed)")
            self.user.isFollowed = isFollowed
            self.collectionView.reloadData()
        }
    }
    
    private func fetchUserStats(){
        UserService.shared.fetchUserStats(uid: user.uid) { (stats) in
            self.user.stats = stats
            self.collectionView.reloadData()
        }
    }
}

//MARK: - UICollectinViewDataSource

extension ProfileController {
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tweets.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as! TweetCell
        cell.tweet = self.tweets[indexPath.row]
        return cell
    }
}


//MARK: - UICollectionViewDelegate

extension ProfileController {
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerIdentifier, for: indexPath) as! ProfileHeader
        header.delegate = self
        header.user = user
        return header
    }
}


//MARK: - UICollectionViewDelegateFlowLayout

extension ProfileController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width, height: 350)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 120)
    }
}

//MARK: - ProfileHeaderProtocol
extension ProfileController: ProfileHeaderProtocol {
    
    func handleEditProfileFollow(_ header: ProfileHeader) {
        let isFollowed = self.user.isFollowed
        if !user.isCurrentUser {
            if isFollowed {
                UserService.shared.unfollowUser(uid: user.uid) { (error, ref) in
                    self.user.isFollowed = false
                    self.collectionView.reloadData()
                }
            }else{
                UserService.shared.followUser(uid: user.uid) { (error, ref) in
                    self.user.isFollowed = true
                    self.collectionView.reloadData()
                }
            }
        }
        
    }
    
    
    func handleDismissal() {
        self.navigationController?.popViewController(animated: true)
    }
}
