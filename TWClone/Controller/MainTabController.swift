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
        let feed = FeedController()
        let explore = ExploreController()
        let notifications = NotificationController()
        let conversations = ConversationsController()
        
        viewControllers = [feed, explore, notifications, conversations]
    }

}
