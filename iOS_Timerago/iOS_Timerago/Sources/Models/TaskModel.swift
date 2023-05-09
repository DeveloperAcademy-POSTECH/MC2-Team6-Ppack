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
    var interval:String
    
    
    init(id:String =  UUID().uuidString ,emoji: String, interval: String) {
        self.id = id
        self.emoji = emoji
        self.interval = interval
    }
    
    mutating func updateEmoji(emoji:String) {
        self.emoji = emoji
    }
    
    mutating func updateInterval(interval:String) {
        self.interval = interval
    }
    
}
