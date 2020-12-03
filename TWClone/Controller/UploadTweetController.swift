//
//  UploadTweetController.swift
//  TWClone
//
//  Created by RafaelAsencio on 03/12/2020.
//

import UIKit

class UploadTweetController: UIViewController {
    
    //MARK: - Properties
    private lazy var actionButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.backgroundColor = .twitterBlue
        btn.setTitle("Tweet", for: .normal)
        btn.titleLabel?.textAlignment = .center
        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        btn.setTitleColor(.white, for: .normal)
        btn.frame = CGRect(x: 0, y: 0, width: 64, height: 32)
        btn.layer.cornerRadius = 32 / 2
        btn.addTarget(self, action: #selector(handleUploadTweet), for: .touchUpInside)
        return btn
    }()
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    //MARK: - Selectors
    @objc func handleCancel(){
        dismiss(animated: true)
    }
    @objc func handleUploadTweet(){
        print("DEBUG: upload tweet")
    }
    //MARK: - API
    
    //MARK: - Helpers
    private func configureUI(){
        self.view.backgroundColor = .white
        self.navigationController?.navigationBar.barTintColor = .white
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(handleCancel))
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: actionButton)
        
    }
    
}
