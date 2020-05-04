//
//  TabBarController.swift
//  BudgetTelegram
//
//  Created by Никита on 02.05.2020.
//  Copyright © 2020 Nikita Glushchenko. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController {
    
    static let layout = UICollectionViewFlowLayout()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        let chatsController = UINavigationController(rootViewController: ChatsController(collectionViewLayout: TabBarController.layout))
        chatsController.title = "Chats"
        chatsController.tabBarItem.image = UIImage(systemName: "message.fill")
        
        let contactsController = UINavigationController(rootViewController: ContactsViewController())
        contactsController.title = "Contacts"
        contactsController.tabBarItem.image = UIImage(systemName: "person.fill")
        
        let callsController = UINavigationController(rootViewController: CallsViewController())
        callsController.title = "Calls"
        callsController.tabBarItem.image = UIImage(systemName: "phone.fill")
        
        let settingsController = UINavigationController(rootViewController: SettingsViewController())
        settingsController.title = "Settings"
        settingsController.tabBarItem.image = UIImage(systemName: "gear")
        
        viewControllers = [chatsController, settingsController]
        
    }
}
