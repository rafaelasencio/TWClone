//
//  UploadTweetController.swift
//  TWClone
//
//  Created by RafaelAsencio on 03/12/2020.
//

import UIKit

class UploadTweetController: UIViewController {
    
    //MARK: - Properties
    private let user: User
    private let config: UploadTweetConfiguration
    private lazy var viewModel = UploadTweetViewModel(config: config)
    
    private lazy var actionButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.backgroundColor = .twitterBlue
        btn.setTitle(viewModel.actionButtonTitle, for: .normal)
        btn.titleLabel?.textAlignment = .center
        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        btn.setTitleColor(.white, for: .normal)
        btn.frame = CGRect(x: 0, y: 0, width: 64, height: 32)
        btn.layer.cornerRadius = 32 / 2
        btn.addTarget(self, action: #selector(handleUploadTweet), for: .touchUpInside)
        return btn
    }()
    
    private let profileImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.setDimensions(width: 48, height: 48)
        iv.layer.cornerRadius = 48 / 2
        iv.backgroundColor = .twitterBlue
        return iv
    }()
    
    private lazy var replyLabel: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont.systemFont(ofSize: 14)
        lbl.textColor = .lightGray
        lbl.text = "replying to @someone"
        lbl.widthAnchor.constraint(equalToConstant: view.frame.width).isActive = true
        return lbl
    }()
    
    private let captionTextView = CaptionTextView()
    
    //MARK: - Lifecycle
    
    init(user: User, config: UploadTweetConfiguration) {
        self.user = user
        self.config = config
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        switch config {
        case .tweet:
            print("DEBUG: is tweet")
        case .reply(let tweet):
            print("DEBUG: is replying \(tweet.user.username)")
        }
    }
    
    //MARK: - Selectors
    @objc func handleCancel(){
        dismiss(animated: true)
    }
    @objc func handleUploadTweet(){
        print("DEBUG: upload tweet")
        guard let caption = captionTextView.text else { return }
        TweetService.shared.uploadTweet(caption: caption, type: config) { (error, reference) in
            if let error = error {
                print("DEBUG: error "+error.localizedDescription)
                return
            }
            print("DEBUG: tweet uploaded to database")
            self.dismiss(animated: true, completion: nil)
        }
    }
    //MARK: - API
    
    //MARK: - Helpers
    private func configureUI(){
        self.view.backgroundColor = .white
        configureNavigationBar()
        
        let imageCaptionstack = UIStackView(arrangedSubviews: [profileImageView, captionTextView])
        imageCaptionstack.axis = .horizontal
        imageCaptionstack.spacing = 12
        imageCaptionstack.alignment = .leading
        
        let stack = UIStackView(arrangedSubviews: [replyLabel, imageCaptionstack])
        stack.axis = .vertical
        stack.spacing = 12
//        stack.alignment = .leading
        view.addSubview(stack)
        stack.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, right: view.rightAnchor,
                     paddingTop: 16, paddingLeft: 16, paddingRight: 16)
        profileImageView.sd_setImage(with: user.profileImageURL, completed: nil)
        
        captionTextView.placeholderLabel.text = viewModel.placeholderText
        replyLabel.isHidden = !viewModel.shouldShowReplyLabel
        guard let replyText = viewModel.replyText else { return }
        replyLabel.text = replyText
    }
    
    private func configureNavigationBar(){
        self.navigationController?.navigationBar.barTintColor = .white
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(handleCancel))
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: actionButton)
    }
    
}
