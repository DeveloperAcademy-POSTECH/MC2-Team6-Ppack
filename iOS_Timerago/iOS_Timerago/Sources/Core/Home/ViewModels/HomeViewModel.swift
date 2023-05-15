//
//  HomeViewModel.swift
//  iOS_Timerago
//
//  Created by yongbeomkwak on 2023/05/03.
//

import Foundation

class HomeViewModel : ObservableObject {
    

    let dataService = DataService()

    
    @Published var routines: [RoutineModel]
    
    init() {
        self.routines = dataService.loadJsonFile() ?? []
        
    }
    
    
    
   

    func addOrUpdate(routine:RoutineModel){
        
        if let index = routines.firstIndex(where: {$0.id == routine.id}) {
            routines[index] = routine
            
        } else {
            routines.append(routine)
        }
        
       
        applyChange()
    }
    
    func save() {
        dataService.saveJsonData(data: routines)
    }
    
    func applyChange() {
        save()
        load()
    }
    
    func load()  {
        self.routines = dataService.loadJsonFile() ?? []
    }
    
    
    
    
}
