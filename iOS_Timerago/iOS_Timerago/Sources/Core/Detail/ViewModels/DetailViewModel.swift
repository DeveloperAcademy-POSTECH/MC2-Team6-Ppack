//
//  DetailViewModel.swift
//  iOS_Timerago
//
//  Created by yongbeomkwak on 2023/05/04.
//

import Foundation

class DetailViewModel : ObservableObject {

    
    @Published var routine:RoutineModel
    @Published var title: String = ""
    
    init(routine:RoutineModel){
            self.routine = routine
            title = routine.title
    }
    
    
    
    
}
