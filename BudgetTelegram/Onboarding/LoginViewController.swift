//
//  LoginViewController.swift
//  BudgetTelegram
//
//  Created by Никита on 30.04.2020.
//  Copyright © 2020 Nikita Glushchenko. All rights reserved.
//

//import UIKit
//import AuthenticationServices
//
//class LoginViewController: UIViewController {
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        setup()
//    }
//    
//    private func setup() {
//           hideKeyboardWhenTappedAround()
//           setupSignInWithAppleButton()
//       }
// 
//    private func setupSignInWithAppleButton() {
//        let button = ASAuthorizationAppleIDButton(type: .signIn, style: .white)
//        button.translatesAutoresizingMaskIntoConstraints = false
//        NSLayoutConstraint.activate([
//            button.heightAnchor.constraint(equalToConstant: 50)
//        ])
//        button.addTarget(self, action: #selector(appleIdButtonClicked), for: .touchUpInside)
//        view.addSubview(button)
//    }
//
//    @objc func appleIdButtonClicked() {
//        let request = ASAuthorizationAppleIDProvider().createRequest()
//        request.requestedScopes = [.fullName, .email]
//
//        let controller = ASAuthorizationController(authorizationRequests: [request])
//        controller.delegate = self
//        controller.presentationContextProvider = self
//        controller.performRequests()
//    }
//
//    func performExistingAccountSetupFlows() {
//        let requests = [ASAuthorizationAppleIDProvider().createRequest(),
//                        ASAuthorizationPasswordProvider().createRequest()]
//
//        let authorizationController = ASAuthorizationController(authorizationRequests: requests)
//        authorizationController.delegate = self
//        authorizationController.presentationContextProvider = self
//        authorizationController.performRequests()
//    }
//
//}
//
//extension LoginViewController: ASAuthorizationControllerDelegate {
//    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
//        if let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential {
//
//            let userIdentifier = appleIDCredential.user
////            let fullName = appleIDCredential.fullName
////            let email = appleIDCredential.email
//
//            // Create an account in your system.
//            do {
//                guard let userIdentifierData = userIdentifier.data(using: .utf8) else { return }
//                try Keychain.set(value: userIdentifierData,
//                                 account: KeyChainKeys.userId)
//            } catch {
//                // handle error
//                print(error)
//                return
//            }
//
////            let viewController = LoggedInViewController()
////            let credentials = User(userIdentifier: userIdentifier,
////                                   firstName: fullName?.givenName,
////                                   lastName: fullName?.familyName,
////                                          email: email)
//        } else if let passwordCredential = authorization.credential as? ASPasswordCredential {
//            // Sign in using an existing iCloud Keychain credential.
//            let username = passwordCredential.user
//            let password = passwordCredential.password
//
//            DispatchQueue.main.async { [weak self] in
//                let message = "The app has received your selected credential from the keychain. \n\n Username: \(username)\n Password: \(password)"
//                let alertController = UIAlertController(title: "Keychain Credential Received",
//                                                        message: message,
//                                                        preferredStyle: .alert)
//                alertController.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: nil))
//                self?.present(alertController, animated: true, completion: nil)
//            }
//        }
//    }
//
//    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
//        print(error)
//    }
//}
//
//extension LoginViewController: ASAuthorizationControllerPresentationContextProviding {
//
//    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
//        return view.window!
//    }
//
//}
