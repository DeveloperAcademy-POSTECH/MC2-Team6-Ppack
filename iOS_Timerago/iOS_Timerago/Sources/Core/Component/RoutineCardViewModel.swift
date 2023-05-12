//
//  RoutineCardViewModel.swift
//  iOS_Timerago
//
//  Created by 송기원 on 2023/05/11.
//

import Foundation

final class RoutineCardViewModel: ObservableObject {
    @Published var showingSheet = false
    @Published var tasks: [TaskModel] = [] {
        didSet {
            tasks.forEach { self.intervals.append( $0.interval ) }
        }
    }
    @Published var intervals: [String] = [] {
        didSet {
            if time == 0 && taskTime.isEmpty {
                self.time = intervals.map { Int(String($0)) ?? 0 }.reduce(0) { $0 + $1 }
                self.taskTime = intervals.map { (Int($0) ?? 0) * 60 }
            }
        }
    }
    @Published var time: Int = 0
    @Published var taskTime: [Int] = []
}
