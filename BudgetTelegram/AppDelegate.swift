//
//  AppDelegate.swift
//  Practice
//
//  Created by Никита on 18.04.2020.
//  Copyright © 2020 Nikita Glushchenko. All rights reserved.
//
//app icon from https://icons8.ru/
import UIKit
import Firebase

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    let contactsNavigationController = ContactsNavigationController()
    let callsNavigationController = CallsNavigationController()
    let chatsNavigationController = ChatsNavigationController()
    let settingsNavigationController = SettingsNavigationController()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let contactsItem = UITabBarItem()
        contactsItem.title = "Contacts"
        contactsItem.image = UIImage(systemName: "person.fill")
        contactsNavigationController.tabBarItem = contactsItem
        
        let callsItem = UITabBarItem()
        callsItem.title = "Calls"
        callsItem.image = UIImage(systemName: "phone.fill")
        callsNavigationController.tabBarItem = callsItem
        
        let chatsItem = UITabBarItem()
        chatsItem.title = "Chats"
        chatsItem.image = UIImage(systemName: "message.fill")
        chatsNavigationController.tabBarItem = chatsItem
        
        let settingsItem = UITabBarItem()
        settingsItem.title = "Settings"
        settingsItem.image = UIImage(systemName: "gear")
        settingsNavigationController.tabBarItem = settingsItem

        let tabBarController = UITabBarController()
        tabBarController.viewControllers = [contactsNavigationController, callsNavigationController, chatsNavigationController, settingsNavigationController]
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = tabBarController
        window?.makeKeyAndVisible()
        
        FirebaseApp.configure()
        
        return true
    }
}

