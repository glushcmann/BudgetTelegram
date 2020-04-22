//
//  ContactsNavigationController.swift
//  BudgetTelegram
//
//  Created by Никита on 21.04.2020.
//  Copyright © 2020 Nikita Glushchenko. All rights reserved.
//

import UIKit

class ContactsNavigationController: UINavigationController {
    
    let contactsVC = ContactsViewController()
    
    override func viewDidLoad() {
        self.viewControllers = [contactsVC]
    }
    
}
