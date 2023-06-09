//
//  RoutineModel.swift
//  iOS_Timerago
//
//  Created by yongbeomkwak on 2023/05/03.
//

import Foundation

struct RoutineModel:Identifiable, Codable,Equatable {
    
    var id:String
    var task:[TaskModel]
    var title:String
    
    init(id: String = UUID().uuidString, task: [TaskModel], title: String) {
        self.id = id
        self.task = task
        self.title = title
    }
    
    static func == (lhs: RoutineModel, rhs: RoutineModel) -> Bool {
        lhs.id == rhs.id // 아이디가 같으면 같은 객체로 인식
    }
    

    
}
