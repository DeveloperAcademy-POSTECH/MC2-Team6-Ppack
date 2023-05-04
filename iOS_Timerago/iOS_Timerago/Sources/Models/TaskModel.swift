//
//  Task.swift
//  iOS_Timerago
//
//  Created by yongbeomkwak on 2023/05/03.
//

import Foundation

struct TaskModel: Identifiable, Codable,Equatable {
    var id: String = UUID().uuidString
    let emoji:String
    let interval:Int
    
    
}
