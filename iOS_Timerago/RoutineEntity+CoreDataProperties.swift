//
//  RoutineEntity+CoreDataProperties.swift
//  iOS_Timerago
//
//  Created by yongbeomkwak on 2023/05/09.
//
//

import Foundation
import CoreData


extension RoutineEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<RoutineEntity> {
        return NSFetchRequest<RoutineEntity>(entityName: "RoutineEntity")
    }

    @NSManaged public var id: String
    @NSManaged public var task: [TaskEntity]
    @NSManaged public var title: String

}

extension RoutineEntity : Identifiable {

}
