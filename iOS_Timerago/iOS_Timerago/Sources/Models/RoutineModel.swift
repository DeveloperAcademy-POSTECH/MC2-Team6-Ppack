//
//  RoutineModel.swift
//  iOS_Timerago
//
//  Created by yongbeomkwak on 2023/05/03.
//

import Foundation

struct RoutineModel:Identifiable, Codable,Equatable {
    
    let id:String
    let task:[TaskModel]
    let title:String
    let totalTime:Int
    
    static func == (lhs: RoutineModel, rhs: RoutineModel) -> Bool {
        lhs.id == rhs.id // 아이디가 같으면 같은 객체로 인식
    }
    

    
}
