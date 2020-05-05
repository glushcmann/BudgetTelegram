//
//  User.swift
//  BudgetTelegram
//
//  Created by Никита on 01.05.2020.
//  Copyright © 2020 Nikita Glushchenko. All rights reserved.
//

import UIKit
import CoreData

extension ChatsController {
    
    func setupData() {
        
        clearData()
        let delegate = UIApplication.shared.delegate as? AppDelegate
        
        if let context = delegate?.persistentContainer.viewContext {
            
            createSteveMessagesWithContext(context: context )
            
            let donald = NSEntityDescription.insertNewObject(forEntityName: "User", into: context) as! User
            donald.name = "Donald"
            donald.profileImage = "2"
            ChatsController.createMessageWithText(text: "efjpwjghvoeuh fbhvoirb ireugheri p  iuroehgreio", user: donald, minutesAgo: 60*24, context: context)
            
            let gandhi = NSEntityDescription.insertNewObject(forEntityName: "User", into: context) as! User
            gandhi.name = "Gandi"
            gandhi.profileImage = "2"
            ChatsController.createMessageWithText(text: "efjpwjghvoeuh", user: gandhi , minutesAgo: 60*24*8, context: context)
             
            do {
                try context.save()
            } catch let error {
                print(error)
            }
            
        }
    }
    
    func createSteveMessagesWithContext(context: NSManagedObjectContext) {
        
        let steve = NSEntityDescription.insertNewObject(forEntityName: "User", into: context) as! User
        steve.name = "Steve"
        steve.profileImage = "3"
        ChatsController.createMessageWithText(text: "hi 1 heiroubhrei", user: steve, minutesAgo: 2, context: context)
        ChatsController.createMessageWithText(text: "hi 2 hfibhrpto", user: steve, minutesAgo: 1, context: context)
        ChatsController.createMessageWithText(text: "hi 1 heiroubhrei", user: steve, minutesAgo: 2, context: context)
        ChatsController.createMessageWithText(text: "hi 2 hfibhrpto", user: steve, minutesAgo: 1, context: context)
        ChatsController.createMessageWithText(text: "hi 1 heiroubhrei", user: steve, minutesAgo: 2, context: context)
        ChatsController.createMessageWithText(text: "hi 2 hfibhrpto", user: steve, minutesAgo: 1, context: context)
        ChatsController.createMessageWithText(text: "hi 1 heiroubhrei", user: steve, minutesAgo: 2, context: context)
        ChatsController.createMessageWithText(text: "hi 2 hfibhrpto", user: steve, minutesAgo: 1, context: context)

        //resronse message
        ChatsController.createMessageWithText(text: "answer", user: steve, minutesAgo: 0, context: context, isSender: true)
        ChatsController.createMessageWithText(text: "answer", user: steve, minutesAgo: 0, context: context, isSender: true)
        ChatsController.createMessageWithText(text: "answer", user: steve, minutesAgo: 0, context: context, isSender: true)
        ChatsController.createMessageWithText(text: "answer", user: steve, minutesAgo: 0, context: context, isSender: true)
        ChatsController.createMessageWithText(text: "answer", user: steve, minutesAgo: 0, context: context, isSender: true)
        ChatsController.createMessageWithText(text: "answer", user: steve, minutesAgo: 0, context: context, isSender: true)
        ChatsController.createMessageWithText(text: "answer", user: steve, minutesAgo: 0, context: context, isSender: true)
        ChatsController.createMessageWithText(text: "answer", user: steve, minutesAgo: 0, context: context, isSender: true)
        ChatsController.createMessageWithText(text: "answer", user: steve, minutesAgo: 0, context: context, isSender: true)
        ChatsController.createMessageWithText(text: "answer", user: steve, minutesAgo: 0, context: context, isSender: true)
        ChatsController.createMessageWithText(text: "answer", user: steve, minutesAgo: 0, context: context, isSender: true)
        ChatsController.createMessageWithText(text: "answer", user: steve, minutesAgo: 0, context: context, isSender: true)
        
    }
    
    static func createMessageWithText(text: String, user: User, minutesAgo: Double, context: NSManagedObjectContext, isSender: Bool = false) -> Message {
        
        let message = NSEntityDescription.insertNewObject(forEntityName: "Message" , into: context) as! Message
        message.user = user
        message.text = text
        message.date = NSDate().addingTimeInterval(-minutesAgo*60) as Date?
        message.isSender = NSNumber(value: isSender) as! Bool
        
        user.lastMessage = message
        
        return message
        
    }
     
    func clearData() {
        
        let delegate = UIApplication.shared.delegate as? AppDelegate

        if let context = delegate?.persistentContainer.viewContext {
            
            do {
                let entityNames = ["User", "Message"]
                for entityName in entityNames {
                    let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
                    let objects  = try context.fetch(fetchRequest) as! [NSManagedObject]
                    for object in objects  {
                        context.delete(object )
                    }
                }
                try context.save()
            } catch let error {
                print(error)
            }
        }
    }
    
}

