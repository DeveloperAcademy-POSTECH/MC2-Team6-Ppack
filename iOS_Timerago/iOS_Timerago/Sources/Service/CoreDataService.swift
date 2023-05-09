//
//  LocalFileManager.swift
//  iOS_Timerago
//
//  Created by yongbeomkwak on 2023/05/06.
//

import Foundation
import CoreData

class CoreDataService : ObservableObject {
    
    static let shared:CoreDataService = CoreDataService()
    
    private let container: NSPersistentContainer
    private let containerName: String = "RoutineContainer"
    private let routineEntityName:String = "RoutineEntity"
    private let taskEntityName:String = "TaskEntity"
    
    @Published var savedEntities: [RoutineEntity] = []
    
    init() {
        self.container = NSPersistentContainer(name: containerName)
        
        self.container.loadPersistentStores { _, error in
            
            if let error = error {
                print("Error loading Core Data! \(error)")
            }
            
            self.getRoutines()
        }
        
    }
    
    func getRoutines() {
            let request = NSFetchRequest<RoutineEntity>(entityName: routineEntityName)
            
            do {
                savedEntities = try container.viewContext.fetch(request)
            } catch let error {
                print("Error fetching Portfolio Entities. \(error)")
            }
            
            
        }
    
}
