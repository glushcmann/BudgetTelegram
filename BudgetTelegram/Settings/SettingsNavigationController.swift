//
//  ViewController.swift
//  Practice
//
//  Created by Никита on 18.04.2020.
//  Copyright © 2020 Nikita Glushchenko. All rights reserved.
//

import UIKit

class SettingsNavigationController: UINavigationController {

    let settingsVC = SettingsViewController()
    
    override func viewDidLoad() {
        self.viewControllers = [settingsVC]
    }
    
}
