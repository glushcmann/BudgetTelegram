//
//  UIViewController+HideKeyboard.swift
//  BudgetTelegram
//
//  Created by Никита on 30.04.2020.
//  Copyright © 2020 Nikita Glushchenko. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {

    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard(_:)))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }

    @objc func dismissKeyboard(_ gestureRecognizer: UIGestureRecognizer) {
        let location = gestureRecognizer.location(in: view)
        let hitTestView = view.hitTest(location, with: UIEvent())
        if hitTestView is UIButton { return }

        view.endEditing(true)
    }

}
