//
//  Message+CoreDataProperties.swift
//  BudgetTelegram
//
//  Created by Никита on 01.05.2020.
//  Copyright © 2020 Nikita Glushchenko. All rights reserved.
//
//

import Foundation
import CoreData


extension Message {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Message> {
        return NSFetchRequest<Message>(entityName: "Message")
    }

    @NSManaged public var text: String?
    @NSManaged public var date: Date?
    @NSManaged public var user: User?

}
