//
//  MainTabController.swift
//  TWClone
//
//  Created by RafaelAsencio on 30/11/2020.
//

import UIKit

class MainTabController: UITabBarController {

    //MARK: - Properties
    let actionButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.tintColor = .white
        btn.backgroundColor = .twitterBlue
        btn.layer.cornerRadius = 56 / 2
        btn.setImage(UIImage(named: "new_tweet"), for: .normal)
        btn.addTarget(self, action: #selector(actionButtonTapped), for: .touchUpInside)
        return btn
    }()
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        self.configureVCs()
        self.configureUI()
    }
    
    //MARK: - Selectors
    @objc func actionButtonTapped(){
        print("handle action...")
    }
    
    //MARK: - Helpers
    
    private func configureUI(){
        view.addSubview(actionButton)
        actionButton.anchor(bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.rightAnchor,
                            paddingBottom: 64, paddingRight: 16, width: 56, height: 56)
    }
    
    private func configureVCs(){
        let feed          = FeedController()
        let explore       = ExploreController()
        let notifications = NotificationController()
        let conversations = ConversationsController()
        let nav1 = templateNavigationController(imageName: "home_unselected", rootVC: feed)
        let nav2 = templateNavigationController(imageName: "search_unselected", rootVC: explore)
        let nav3 = templateNavigationController(imageName: "like_unselected", rootVC: notifications)
        let nav4 = templateNavigationController(imageName: "ic_mail_outline_white_2x-1", rootVC: conversations)
        
        viewControllers = [nav1, nav2, nav3, nav4]
    }
    
    private func templateNavigationController(imageName: String, rootVC: UIViewController)->UINavigationController{
        let nav = UINavigationController(rootViewController: rootVC)
        nav.tabBarItem.image = UIImage(named: imageName)
        nav.navigationBar.tintColor = .white
        return nav
    }

}
