//
//  TaskEntity+CoreDataProperties.swift
//  iOS_Timerago
//
//  Created by yongbeomkwak on 2023/05/09.
//
//

import Foundation
import CoreData


extension TaskEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<TaskEntity> {
        return NSFetchRequest<TaskEntity>(entityName: "TaskEntity")
    }

    @NSManaged public var emoji: String
    @NSManaged public var id: String
    @NSManaged public var interval: String

}

extension TaskEntity : Identifiable {

}
