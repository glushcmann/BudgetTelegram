//
//  ChatLogController.swift
//  BudgetTelegram
//
//  Created by Никита on 01.05.2020.
//  Copyright © 2020 Nikita Glushchenko. All rights reserved.
//

import UIKit
import CoreData

class ChatLogController: UICollectionViewController, UICollectionViewDelegateFlowLayout, NSFetchedResultsControllerDelegate {
    
    private let cellID = "cellID"
    
    var friend: User? {
        didSet {
            navigationItem.title = friend?.name
        }
    }
    
    // FIXME: didnt see last message
    
    let messageInputContainer: UIView = {
        let view = UIView()
        view.backgroundColor = .systemBackground
        return view
    }()
    
    let inputTextField: UITextField = {
        let textField  = UITextField()
        textField.placeholder = "Enter message here"
        textField.backgroundColor = .systemBackground
        textField.layer.cornerRadius = 15
        return textField
    }()
    
    let dividerLine: UIView = {
        let line = UIView()
        line.backgroundColor = UIColor(white: 0.85, alpha: 1)
        return line
    }()
    
    lazy var sendButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setTitle("Send", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 16)
        button.addTarget(self, action: #selector(handleSend), for: .touchUpInside)
        return button
    }()
    
    var bottomConstraint: NSLayoutConstraint?
    var collectionViewContraint: NSLayoutConstraint?
    var blockOperations = [BlockOperation]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        do {
            try fetchedResultController.performFetch()
        } catch let error {
            print(error )
        }
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Simulate", style: .plain, target: self, action: #selector(simulate))
 
        collectionView?.contentInsetAdjustmentBehavior = UIScrollView.ContentInsetAdjustmentBehavior.automatic
        tabBarController?.tabBar.isHidden = true
        self.hideKeyboardWhenTappedAround()
        
        collectionView?.backgroundColor = .systemBackground
        collectionView?.register(ChatLogMessageCell.self, forCellWithReuseIdentifier: cellID)
        
        view.addSubview(messageInputContainer)
        view.addConstrint(withVisualFormat: "H:|[v0]|", views: messageInputContainer)
        view.addConstrint(withVisualFormat: "V:[v0(80)]", views: messageInputContainer)
        
        bottomConstraint = NSLayoutConstraint(item: messageInputContainer, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1, constant: 0)
        view.addConstraint(bottomConstraint!)
        
        setupInputComponents()
        
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardNotification), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardNotification), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    lazy var fetchedResultController: NSFetchedResultsController<NSFetchRequestResult> = {
        let request =  NSFetchRequest<NSFetchRequestResult>(entityName: "Message")
        request.sortDescriptors = [NSSortDescriptor(key: "date", ascending: true)]
        request.predicate = NSPredicate(format: "user.name = %@", self.friend!.name!)
        let delegate = UIApplication.shared.delegate as! AppDelegate
        let contex = delegate.persistentContainer.viewContext
        let fetch = NSFetchedResultsController(fetchRequest: request, managedObjectContext: contex, sectionNameKeyPath: nil, cacheName: nil)
        fetch.delegate = self
        return fetch
    }()
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        if type == .insert {
            blockOperations.append(BlockOperation(block: {
                self.collectionView.insertItems(at: [newIndexPath!])
            }))
        }
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        collectionView.performBatchUpdates({
            
            for operation in self.blockOperations {
                operation.start()
            }
            
        }, completion: { (completed) in
            
            let lastItem = self.fetchedResultController.sections![0].numberOfObjects - 1
            let indexPath = IndexPath(item: lastItem, section: 0)
            self.collectionView.scrollToItem(at: indexPath, at: .bottom, animated: true)
            
        })
    }
    
    @objc func simulate() {
        
        let delegate = UIApplication.shared.delegate as! AppDelegate
        let contex = delegate.persistentContainer.viewContext
        
        ChatsController.createMessageWithText(text:  "Here is text message that was sent few minutes ago...", user: friend!, minutesAgo: 1, context: contex)
        ChatsController.createMessageWithText(text:  "Here is another text message that was sent few minutes ago...", user: friend!, minutesAgo: 1, context: contex)
        
        do {
            try contex.save()
        } catch let error{
            print(error)
        }
    }
    
    @objc func handleKeyboardNotification(notification: Notification) {
        if let userInfo = notification.userInfo {
            
            let keyboardFrame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect
            let isKeyboardShowing = notification.name == UIResponder.keyboardWillShowNotification
            bottomConstraint?.constant = isKeyboardShowing ? (-keyboardFrame!.height + 30) : 0
            
            UIView.animate(withDuration: 0, delay: 0, options: .curveEaseOut, animations: {
                
                self.view.layoutIfNeeded()
                
            }, completion: { (completed) in
                
                let lastItem = self.fetchedResultController.sections![0].numberOfObjects - 1
                let indexPath = IndexPath(item: lastItem, section: 0)
                self.collectionView.scrollToItem(at: indexPath, at: .bottom, animated: true)
                
            })
            
        }
    }
    
    @objc func handleSend() {
        
        let delegate = UIApplication.shared.delegate as! AppDelegate
        let contex = delegate.persistentContainer.viewContext
        
        ChatsController.createMessageWithText(text: inputTextField.text!, user: friend!, minutesAgo: 0, context: contex, isSender: true)
        
        do {
            try contex.save()
            inputTextField.text = nil
        } catch let error{
            print(error)
        }
    }
    
    func setupInputComponents() {
        
        messageInputContainer.addSubview(inputTextField)
        messageInputContainer.addSubview(sendButton)
        messageInputContainer.addSubview(dividerLine)
        
        messageInputContainer.addConstrint(withVisualFormat: "H:|-10-[v0]-10-[v1(60)]-10-|", views: inputTextField, sendButton)
        messageInputContainer.addConstrint(withVisualFormat: "V:|-10-[v0]-40-|", views: inputTextField)
        messageInputContainer.addConstrint(withVisualFormat: "V:|-10-[v0]-40-|", views: sendButton)

        messageInputContainer.addConstrint(withVisualFormat: "V:|[v0(0.6)]", views: dividerLine)
        messageInputContainer.addConstrint(withVisualFormat: "H:|[v0]|", views: dividerLine)
        
    }
    
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let count = fetchedResultController.sections?[0].numberOfObjects {
            return count
        }
        return 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! ChatLogMessageCell
        
        let message = fetchedResultController.object(at: indexPath) as! Message
        cell.messageTextView.text = message.text
        
        if let messageText = message.text, let profileImage = message.user?.profileImage {
            
            cell.profileImageView.image = UIImage(named: profileImage)
            
            let size = CGSize(width: 250, height: 1000)
            let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
            let estimatedFrame = String(messageText).boundingRect(with: size, options: options, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18)], context: nil)
            
            if !message.isSender {
                
                cell.messageTextView.frame = CGRect(x: 45 + 8, y: 10, width: estimatedFrame.width + 16, height: estimatedFrame.height + 15 )
                cell.textBubbleView.frame = CGRect(x: 45, y: 10, width: estimatedFrame.width + 10, height: estimatedFrame.height + 15)
                cell.profileImageView.isHidden = false
                cell.messageTextView.textColor = .black
                cell.textBubbleView.backgroundColor = UIColor(white: 0.95, alpha: 1)
                
            } else {
                
                //outgoing sending message
                cell.messageTextView.frame = CGRect(x: view.frame.width - estimatedFrame.width - 16 - 16, y: 5, width: estimatedFrame.width + 16, height: estimatedFrame.height + 15 )
                cell.textBubbleView.frame = CGRect(x: view.frame.width - estimatedFrame.width - 16 - 16 - 8, y: 5, width: estimatedFrame.width + 16 + 8, height: estimatedFrame.height + 15 )
                cell.profileImageView.isHidden = true
                cell.textBubbleView.backgroundColor = .systemBlue
                cell.messageTextView.textColor = .white
                
            }
        
        }
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let message = fetchedResultController.object(at: indexPath) as! Message
        if let messageText = message .text {
            let size = CGSize(width: 250, height: 1000)
            let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
            let estimatedFrame = String(messageText).boundingRect(with: size, options: options, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18)], context: nil)
            
            return CGSize(width: view.frame.width, height: estimatedFrame.height + 25)
        }
        
        return CGSize(width: view.frame.width, height: 90)
    }
    
    
    
}
