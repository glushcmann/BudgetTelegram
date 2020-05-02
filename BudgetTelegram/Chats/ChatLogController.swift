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
    
    var messages: [Message]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView?.register(ChatLogMessageCell.self, forCellWithReuseIdentifier: cellID )
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
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
         return CGSize(width: view.frame.width, height: 70)
    }
}
 
class ChatLogMessageCell: BaseCell {
    
    let messageTextView: UITextView = {
        let messageTextView = UITextView()
        messageTextView.font = .systemFont(ofSize: 14)
        messageTextView.text = "sample text"
        return messageTextView
    }()
    
    override func setupViews() {
        super.setupViews()
        
        addSubview(messageTextView)
        addConstrint(withVisualFormat: "H:|[v0]|", views: messageTextView)
        addConstrint(withVisualFormat: "V:|[v0]|", views: messageTextView)
    }
}
