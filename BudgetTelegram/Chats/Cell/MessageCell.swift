//
//  MessageCell.swift
//  BudgetTelegram
//
//  Created by Никита on 01.05.2020.
//  Copyright © 2020 Nikita Glushchenko. All rights reserved.
//

import UIKit

class MessageCell: BaseCell {
    
    override var isHighlighted: Bool {
        didSet {

            backgroundColor = isHighlighted ? .systemBlue : .systemBackground
            nameLabel.textColor = isHighlighted ? .white : .darkGray
            timeLabel.textColor = isHighlighted ? .white : .darkGray
            messageLabel.textColor = isHighlighted ? .white : .darkGray
            
        }
    }
    
    var message: Message? {
        didSet {
            nameLabel.text = message?.user?.name
            messageLabel.text = message?.text
            if let date = message?.date {
                
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "h:mm a"
                
                let elapsedTimeInSeconds = Date().timeIntervalSince(date)
                let secondInDay: TimeInterval = 60 * 60 * 24
                if elapsedTimeInSeconds > 7 * secondInDay {
                    dateFormatter.dateFormat = "dd/MM/yy"
                } else if elapsedTimeInSeconds > secondInDay {
                    dateFormatter.dateFormat = "EEE"
                }
                
                timeLabel.text = dateFormatter.string(from: date)
            }

            if let image = message?.user?.profileImage {
                profileImageView.image = UIImage(named: image)
                hasReadImageView.image = UIImage(named: image)
            }
        }
    }

    let profileImageView:UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 30
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    let hasReadImageView:UIImageView = {
         let imageView = UIImageView()
         imageView.contentMode = .scaleAspectFill
         imageView.layer.cornerRadius = 10
         imageView.layer.masksToBounds = true
         return imageView
     }()

    let dividerLineView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(white: 0.5, alpha: 0.5)
        return view
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18 )
        label.textColor = .darkGray
        return label
    }()
    
    let messageLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.textColor = .darkGray
        return label
    }()
    
    let timeLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .right
        label.font = .systemFont(ofSize: 14)
        label.textColor = .darkGray
        return label
    }()
    
    override func setupViews() {
        
        addSubview(profileImageView)
        addSubview(dividerLineView)
        
        setupContainerView()
        
        addConstrint(withVisualFormat: "H:|-12-[v0(60)]", views: profileImageView)
        addConstrint(withVisualFormat: "V:[v0(60)]", views: profileImageView)
        NSLayoutConstraint.activate([NSLayoutConstraint(item: profileImageView, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0)])
        
        addConstrint(withVisualFormat: "H:|-82-[v0]|", views: dividerLineView)
        addConstrint(withVisualFormat: "V:[v0(0.4)]|", views: dividerLineView)
    }
    
    private func setupContainerView() {
        
        let containerView = UIView()
        addSubview(containerView)
        
        addConstrint(withVisualFormat: "H:|-90-[v0]|", views: containerView)
        addConstrint(withVisualFormat: "V:[v0(60)]", views: containerView)
        NSLayoutConstraint.activate([NSLayoutConstraint(item: containerView, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0)])
        
        containerView.addSubview(nameLabel)
        containerView.addSubview(messageLabel)
        containerView.addSubview(timeLabel)
        containerView.addSubview(hasReadImageView)
        
        containerView.addConstrint(withVisualFormat: "H:|[v0][v1(80)]-12-|", views: nameLabel, timeLabel)
        containerView.addConstrint(withVisualFormat: "V:|[v0][v1(30)]|", views: nameLabel, messageLabel)
        
        containerView.addConstrint(withVisualFormat: "V:|[v0(20)]", views: timeLabel)
        containerView.addConstrint(withVisualFormat: "H:|[v0]-5-[v1(20)]-12-|", views: messageLabel, hasReadImageView)
        containerView.addConstrint(withVisualFormat: "V:[v0(20)]-5-|", views: hasReadImageView)
        
    }
}
