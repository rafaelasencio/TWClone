//
//  MainTabController.swift
//  TWClone
//
//  Created by RafaelAsencio on 30/11/2020.
//

import UIKit

class MainTabController: UITabBarController {

    //MARK: - Properties
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        self.configureVCs()
    }
    
    //MARK: - Helpers
    
    private func configureVCs(){
        let feed          = FeedController()
        let explore       = ExploreController()
        let notifications = NotificationController()
        let conversations = ConversationsController()
        let nav1 = templateNavigationController(imageName: "home_unselected", rootVC: feed)
        let nav2 = templateNavigationController(imageName: "search_unselected", rootVC: explore)
        let nav3 = templateNavigationController(imageName: "search_unselected", rootVC: notifications)
        let nav4 = templateNavigationController(imageName: "search_unselected", rootVC: conversations)
        
        viewControllers = [nav1, nav2, nav3, nav4]
    }
    
    private func templateNavigationController(imageName: String, rootVC: UIViewController)->UINavigationController{
        let nav = UINavigationController(rootViewController: rootVC)
        nav.tabBarItem.image = UIImage(named: imageName)
        nav.navigationBar.tintColor = .white
        return nav
    }

}
