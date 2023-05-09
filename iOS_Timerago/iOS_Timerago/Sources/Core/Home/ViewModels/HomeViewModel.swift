//
//  HomeViewModel.swift
//  iOS_Timerago
//
//  Created by yongbeomkwak on 2023/05/03.
//

import Foundation

class HomeViewModel : ObservableObject {
    

    
    
    
    private let coreDataService = CoreDataService.shared
    
    @Published var routines: [RoutineModel]
    
    init() {
        self.routines = coreDataService.savedEntities.map({ RoutineModel(id: $0.id, task: $0.task.map({TaskModel(id:$0.id, emoji: $0.emoji, interval: $0.interval)}) , title: $0.title) })
    }
    
    
    private func reloadData() {
        coreDataService.getRoutines()
        self.routines = coreDataService.savedEntities.map({ RoutineModel(id: $0.id, task: $0.task.map({TaskModel(id:$0.id, emoji: $0.emoji, interval: $0.interval)}) , title: $0.title) })
    }
    
    
    
    
    
    
}
