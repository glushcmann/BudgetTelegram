//
//  ChatLogController.swift
//  BudgetTelegram
//
//  Created by Никита on 01.05.2020.
//  Copyright © 2020 Nikita Glushchenko. All rights reserved.
//

import UIKit

class ChatLogController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    private let cellID = "celID"
    
    var friend: User? {
        didSet {
            navigationItem.title = friend?.name
            messages = friend?.messages?.allObjects as? [Message]
            messages = messages?.sorted(by: {$0.date!.compare($1.date!) == .orderedAscending})
        }
    }
    
    let messageInputContainer: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(white: 0.96, alpha: 1)
        return view
    }()
    
    let inputTextField: UITextField = {
        let textField  = UITextField()
        textField.placeholder = "  Enter message"
        textField.backgroundColor = .white
        textField.layer.cornerRadius = 15
        return textField
    }()
    
    let leftItem: UIImageView = {
        let item = UIImageView()
        item.image = UIImage(systemName: "paperclip")
        return item
    }()
    
    let rightItem: UIImageView = {
        let item = UIImageView()
        item.image = UIImage(systemName: "mic")
        return item
    }()
    
    let dividerLine: UIView = {
    let line = UIView()
    line.backgroundColor = UIColor(white: 0.9, alpha: 1)
    return line
    }()
    
    var messages: [Message]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tabBarController?.tabBar.isHidden = true
        
        collectionView?.backgroundColor = .systemBackground
        collectionView?.register(ChatLogMessageCell.self, forCellWithReuseIdentifier: cellID )
        
        view.addSubview(messageInputContainer)
        view.addConstrint(withVisualFormat: "H:|[v0]|", views: messageInputContainer)
        view.addConstrint(withVisualFormat: "V:[v0(78)]|", views: messageInputContainer)
        setupInputComponents()
    }
    
    func setupInputComponents() {
        
        messageInputContainer.addSubview(inputTextField)
        messageInputContainer.addSubview(leftItem)
        messageInputContainer.addSubview(rightItem)
        messageInputContainer.addSubview(dividerLine)
        
        messageInputContainer.addConstrint(withVisualFormat: "H:|-10-[v0(30)]-10-[v1]-10-[v2(30)]-10-|", views: leftItem, inputTextField, rightItem)
        messageInputContainer.addConstrint(withVisualFormat: "V:|-10-[v0(30)]", views: leftItem)
        messageInputContainer.addConstrint(withVisualFormat: "V:|-10-[v0(30)]", views: inputTextField)
        messageInputContainer.addConstrint(withVisualFormat: "V:|-10-[v0(30)]", views: rightItem)
        messageInputContainer.addConstrint(withVisualFormat: "V:|[v0(0.4)]", views: dividerLine)
        messageInputContainer.addConstrint(withVisualFormat: "H:|[v0]|", views: dividerLine)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let count = messages?.count {
            return count
        }
        return 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! ChatLogMessageCell
        cell.messageTextView.text = messages?[indexPath.item].text
        
        if let message = messages?[indexPath.item], let messageText = message.text, let profileImage = message.user?.profileImage {
            
            cell.profileImageView.image = UIImage(named: profileImage)
            
            let size = CGSize(width: 250, height: 1000)
            let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
            let estimatedFrame = String(messageText).boundingRect(with: size, options: options, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18)], context: nil)
            
            if !message.isSender {
                
                cell.messageTextView.frame = CGRect(x: 45 + 8, y: 10, width: estimatedFrame.width + 16, height: estimatedFrame.height + 15 )
                cell.textBubbleView.frame = CGRect(x: 45, y: 10, width: estimatedFrame.width + 10, height: estimatedFrame.height + 15)
                cell.profileImageView.isHidden = false
                cell.messageTextView.textColor = .black
                cell.bubbleImageView.tintColor = UIColor(white: 0.95, alpha: 1)
                
            } else {
                
                //outgoing sending message
                cell.messageTextView.frame = CGRect(x: view.frame.width - estimatedFrame.width - 16 - 16, y: 5, width: estimatedFrame.width + 16, height: estimatedFrame.height + 15 )
                cell.textBubbleView.frame = CGRect(x: view.frame.width - estimatedFrame.width - 16 - 16 - 8, y: 5, width: estimatedFrame.width + 16 + 8, height: estimatedFrame.height + 15 )
                cell.profileImageView.isHidden = true
//                cell.textBubbleView.backgroundColor = .systemBlue
                cell.messageTextView.textColor = .white
                cell.bubbleImageView.tintColor = .systemBlue
                cell.bubbleImageView.image = UIImage(named: "bubble_sent")
                
            }
        
        }
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if let messageText = messages?[indexPath.item].text {
            let size = CGSize(width: 250, height: 1000)
            let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
            let estimatedFrame = String(messageText).boundingRect(with: size, options: options, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18)], context: nil)
            
            return CGSize(width: view.frame.width, height: estimatedFrame.height + 25)
        }
        
        return CGSize(width: view.frame.width, height: 90)
    }
    
}
