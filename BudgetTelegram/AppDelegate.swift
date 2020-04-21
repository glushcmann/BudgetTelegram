//
//  AppDelegate.swift
//  Practice
//
//  Created by Никита on 18.04.2020.
//  Copyright © 2020 Nikita Glushchenko. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    let contactsVC = ContactsViewController()
    let callsVC = CallsViewController()
    let chatsVC = ChatsViewController()
    let settingsNavigationController = SettingsNavigationController()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let contactsItem = UITabBarItem()
        contactsItem.title = "Contacts"
        contactsItem.image = UIImage(systemName: "person.fill")
        contactsVC.tabBarItem = contactsItem
        
        let callsItem = UITabBarItem()
        callsItem.title = "Calls"
        callsItem.image = UIImage(systemName: "phone.fill")
        callsVC.tabBarItem = callsItem
        
        let chatsItem = UITabBarItem()
        chatsItem.title = "Chats"
        chatsItem.image = UIImage(systemName: "message.fill")
        chatsVC.tabBarItem = chatsItem
        
        let settingsItem = UITabBarItem()
        settingsItem.title = "Settings"
        settingsItem.image = UIImage(systemName: "gear")
        settingsNavigationController.tabBarItem = settingsItem

        let tabBarController = UITabBarController()
        tabBarController.viewControllers = [contactsVC, callsVC, chatsVC, settingsNavigationController]
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = tabBarController
        window?.makeKeyAndVisible()
        return true
    }
}

