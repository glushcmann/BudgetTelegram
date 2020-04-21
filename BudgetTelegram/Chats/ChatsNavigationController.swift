//
//  ChatsNavigationController.swift
//  BudgetTelegram
//
//  Created by Никита on 21.04.2020.
//  Copyright © 2020 Nikita Glushchenko. All rights reserved.
//

import UIKit

class ChatsNavigationController: UINavigationController {

    let vc = ChatsViewController()
    
    override func viewDidLoad() {
        self.viewControllers = [vc]
    }
    
}
