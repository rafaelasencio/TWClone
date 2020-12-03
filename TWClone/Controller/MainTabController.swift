//
//  MainTabController.swift
//  TWClone
//
//  Created by RafaelAsencio on 30/11/2020.
//

import UIKit
import Firebase

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
        self.view.backgroundColor = .twitterBlue
//        self.logout()
        self.authenticateUserAndConfigureUI()
    }
    
    //MARK: - API
    func authenticateUserAndConfigureUI(){
        if Auth.auth().currentUser?.uid == nil {
            DispatchQueue.main.async {
                let nav = UINavigationController(rootViewController: LoginController())
                nav.modalPresentationStyle = .fullScreen
                self.present(nav, animated: true, completion: nil)
            }
            print("DEBUG: user not logged in")
        }else{
            self.configureVCs()
            self.configureUI()
            self.fetchUser()
            print("DEBUG: user is logged in")
        }
    }
    
    private func logout(){
        AuthService.shared.logout()
    }
    
    private func fetchUser(){
        UserService.shared.fetchUser()
    }
    
    //MARK: - Selectors
    @objc func actionButtonTapped(){
        print("handle action...")
    }
    
    //MARK: - Helpers
    
    private func configureUI(){
        self.view.addSubview(actionButton)
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
        
        self.viewControllers = [nav1, nav2, nav3, nav4]
    }
    
    private func templateNavigationController(imageName: String, rootVC: UIViewController)->UINavigationController{
        let nav = UINavigationController(rootViewController: rootVC)
        nav.tabBarItem.image = UIImage(named: imageName)
        nav.navigationBar.tintColor = .white
        return nav
    }

}
