//
//  CallsNavigationController.swift
//  BudgetTelegram
//
//  Created by Никита on 21.04.2020.
//  Copyright © 2020 Nikita Glushchenko. All rights reserved.
//

import UIKit

class CallsNavigationController: UINavigationController {
    
    let callsVC = CallsViewController()
    
    override func viewDidLoad() {
        self.viewControllers = [callsVC]
    }
    
}
