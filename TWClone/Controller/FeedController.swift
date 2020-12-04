//
//  FeedController.swift
//  TWClone
//
//  Created by RafaelAsencio on 30/11/2020.
//

import UIKit
import SDWebImage

private let reuseIdentifier = "resueIdentifier"

class FeedController: UICollectionViewController {
    
    //MARK: - Properties
    var user: User? {
        didSet {
            print("DEBUG: user didSet in FeedController")
            self.configureLeftBarButton()
        }
    }
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureUI()
        self.fetchTweets()
    }
    
    //MARK: - Helpers
    private func configureUI(){
        view.backgroundColor = .white
        collectionView.register(TweetCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        collectionView.backgroundColor = .white
        let imageView = UIImageView(image: UIImage(named: "twitter_logo_blue"))
        imageView.contentMode = .scaleAspectFit
        navigationItem.titleView = imageView
        
    }
    
    private func configureLeftBarButton(){
        guard let user = self.user else { return }
        let profileImageView = UIImageView()
        profileImageView.setDimensions(width: 32, height: 32)
        profileImageView.layer.cornerRadius = 32 / 2
        profileImageView.layer.masksToBounds = true
        profileImageView.clipsToBounds = true
        profileImageView.contentMode = .scaleAspectFill
        profileImageView.sd_setImage(with: user.profileImageURL, completed: nil)
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: profileImageView)
    }
    
    //MARK: - API
    
    private func fetchTweets(){
        TweetService.shared.fetchTweets { tweets in
            print("DEBUG: tweets \(tweets)")
        }
    }
}

extension FeedController {
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
        return cell
    }
}

extension FeedController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 120)
    }
}
