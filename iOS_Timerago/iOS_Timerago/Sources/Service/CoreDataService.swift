//
//  LocalFileManager.swift
//  iOS_Timerago
//
//  Created by yongbeomkwak on 2023/05/06.
//

import Foundation
import CoreData

class CoreDataService : ObservableObject {
    
    private let container: NSPersistentContainer
    private let containerName: String = "RoutineContainer"
    private let routineEntityName:String = "RoutineEnitity"
    private let taskEntityName:String = "TaskEntity"
    
    init() {
        self.container = NSPersistentContainer(name: containerName)
        
        self.container.loadPersistentStores { _, error in
            
            if let error = error {
                print("Error loading Core Data! \(error)")
            }
            
            print("Success")
        }
        
    }
    
}
