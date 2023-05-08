//
//  HomeViewModel.swift
//  iOS_Timerago
//
//  Created by yongbeomkwak on 2023/05/03.
//

import Foundation

class HomeViewModel : ObservableObject {
    
    @Published var routines: [RoutineModel] = [RoutineModel(id:UUID().uuidString,  task: [TaskModel(emoji: "✅", interval: 10),TaskModel(emoji: "💄", interval: 12),TaskModel(emoji: "✏️", interval: 10),TaskModel(emoji: "✏️", interval: 13),TaskModel(emoji: "✏️", interval: 10)], title:"Wake-up")
                                              
    ]
    
    
    
}
