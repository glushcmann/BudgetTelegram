//
//  EditViewController.swift
//  Practice
//
//  Created by Никита on 19.04.2020.
//  Copyright © 2020 Nikita Glushchenko. All rights reserved.
//

import UIKit

class EditProfileViewController: UIViewController, UINavigationControllerDelegate {
    
    override func viewDidLoad() {
        
        view.backgroundColor = .red
        super.viewDidLoad()
        self.navigationItem.title = "Edit Profile"
        self.view.backgroundColor = .red
//        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationController?.delegate = self
    }
}
