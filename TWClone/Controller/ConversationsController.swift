//
//  ConversationsController.swift
//  TWClone
//
//  Created by RafaelAsencio on 30/11/2020.
//

import UIKit

class ConversationsController: UIViewController {
    
    //MARK: - Properties
    
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureUI()
    }
    
    //MARK: - Helpers
    private func configureUI(){
        view.backgroundColor = .white
        navigationItem.title = "Messages"
    }
}
