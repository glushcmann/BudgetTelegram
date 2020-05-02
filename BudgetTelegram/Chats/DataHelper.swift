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
            
            let mark = NSEntityDescription.insertNewObject(forEntityName: "User" , into: context) as! User
            mark.name = "mark"
            mark.profileImage = "1"
            createMessageWithText(text: "hello its me", user: mark, minutesAgo: 5, context: context)
            
            let steve = NSEntityDescription.insertNewObject(forEntityName: "User", into: context) as! User
            steve.name = "steve"
            steve.profileImage = "3"
            createMessageWithText(text: "hi 1", user: steve, minutesAgo: 2, context: context)
            createMessageWithText(text: "hi 2", user: steve, minutesAgo: 1, context: context)
            createMessageWithText(text: "hi 3", user: steve, minutesAgo: 0, context: context)
            
            let donald = NSEntityDescription.insertNewObject(forEntityName: "User", into: context) as! User
            donald.name = "donald"
            donald.profileImage = "2"
            createMessageWithText(text: "efjpwjghvoeuh", user: donald, minutesAgo: 3, context: context)
            
            do {
                try context.save()
            } catch let error {
                print(error)
            }
            
        }
        
        loadData()
    }
    
    func createMessageWithText(text: String, user: User, minutesAgo: Double, context: NSManagedObjectContext) {
        let message = NSEntityDescription.insertNewObject(forEntityName: "Message" , into: context) as! Message
        message.user = user
        message.text = text
        message.date = NSDate().addingTimeInterval(-minutesAgo*60) as Date?
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
    
    func loadData() {
        
        let delegate = UIApplication.shared.delegate as? AppDelegate
        
        if let context = delegate?.persistentContainer.viewContext {
            
            if let friends = fetchFriends() {
                messages = [Message]()
                for friend in friends {
                    let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Message")
                    fetchRequest.sortDescriptors = [NSSortDescriptor(key: "date", ascending: false)]
                    fetchRequest.predicate = NSPredicate(format: "user.name = %@", friend.name!)
                    fetchRequest.fetchLimit = 1
                    do {
                        let fetchMessages = try context.fetch(fetchRequest) as? [Message]
                        messages?.append(contentsOf: fetchMessages!)
                    } catch let error {
                       print(error)
                    }
                }
                messages = messages?.sorted(by: {$0.date!.compare($1.date!) == .orderedDescending})
            }
        }
    }
    
    func fetchFriends() -> [User]? {
        
        let delegate = UIApplication.shared.delegate as? AppDelegate
               
        if let context = delegate?.persistentContainer.viewContext {
            let request = NSFetchRequest<NSFetchRequestResult>(entityName: "User")
            do {
                return try context.fetch(request) as? [User]
            } catch let error {
                print(error)
            }
        }
        return nil
    }
}

