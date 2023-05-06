//
//  Task.swift
//  iOS_Timerago
//
//  Created by yongbeomkwak on 2023/05/03.
//

import Foundation

struct TaskModel: Identifiable, Codable,Equatable {
    var id: String
    var emoji:String
    var interval:Int
    
    init(id:String =  UUID().uuidString ,emoji: String, interval: Int) {
        self.id = id
        self.emoji = emoji
        self.interval = interval
    }
    
    mutating func updateEmoji(emoji:String) {
        self.emoji = emoji
    }
    
    mutating func updateInterval(interval:Int) {
        self.interval = interval
    }
    
}
