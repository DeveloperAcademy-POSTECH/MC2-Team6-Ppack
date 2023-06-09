//
//  TimerViewModel.swift
//  backgroundTimerPractice
//
//  Created by 송기원 on 2023/05/03.
//

import SwiftUI
import UserNotifications

final class TimerViewModel: ObservableObject {
    @Published var isActive = false
    @Published var minutes: Double = 0.0
    @Published var tasks: [Int] = []
    @Published var backgroundTime: Date? = nil
    @Published var width: CGFloat = 0
    @Published var count: Double = 0
    @Published var currentIndex = 0
    var totalTime: Double = 0
    var totalWidth: CGFloat = UIScreen.main.bounds.width
    private let notificationCenter = UNUserNotificationCenter.current()
    
    func start() {
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { Timer in
            let finishTimeIntervals = self.getFinishNotificationTimeIntervals()
            guard self.isActive != false else { return }
            
            if self.minutes > 0 {
                self.count += 1
                self.minutes -= 1
            } else if self.minutes == 0 {
                self.currentIndex = self.tasks.count - 1
                Timer.invalidate()
            }
            
            withAnimation(.default){
                if self.minutes != 0 {
                    self.width += (CGFloat(self.totalWidth) / self.totalTime)
                } else {
                    self.width = self.totalWidth
                }
            }
            
            guard self.currentIndex != self.tasks.count - 1 else { return }
            if Int(self.count) >= finishTimeIntervals[self.currentIndex] {
                self.currentIndex += 1
            }
        })
    }
    
    func getTimeString(time: Double) -> String {
        let minutes = Int(self.minutes) / 60
        let seconds = Int(self.minutes) % 60
        
        return String(format: "%02i:%02i", minutes, seconds)
    }
    
    func registerNotification() {
        let totalContent = UNMutableNotificationContent()
        let totalTrigger = UNTimeIntervalNotificationTrigger(timeInterval: minutes, repeats: false)
        totalContent.title = "시간 종료!"
        totalContent.body = "행복한 하루되세요!"
        totalContent.sound = UNNotificationSound(named: UNNotificationSoundName("타임오버.mp3"))
        
        let totalRequest = UNNotificationRequest(identifier: "total", content: totalContent, trigger: totalTrigger)
        
        notificationCenter.add(totalRequest)
    }
    
    func setTasksNotification() {
        let fiveMinsTimeIntervals = getFiveMinsNotificationTimeIntervals()
        
        for timeInterval in fiveMinsTimeIntervals {
            let fiveMinsContent = UNMutableNotificationContent()
            let fiveMinsTrigger = UNTimeIntervalNotificationTrigger(timeInterval: TimeInterval(timeInterval), repeats: false)
            
            fiveMinsContent.title = "5분 남았습니다!"
            fiveMinsContent.body = "서두르세요!"
            fiveMinsContent.sound = UNNotificationSound(named: UNNotificationSoundName("5분알림.mp3"))
            
            let fiveMinsRequest = UNNotificationRequest(identifier: "task\(timeInterval)", content: fiveMinsContent, trigger: fiveMinsTrigger)
            
            notificationCenter.add(fiveMinsRequest)
        }
        
        let finishNotificationTimeIntervals = getFinishNotificationTimeIntervals()
        
        for timeInterval in finishNotificationTimeIntervals {
            let finishContent = UNMutableNotificationContent()
            let finishTrigger = UNTimeIntervalNotificationTrigger(timeInterval: TimeInterval(timeInterval), repeats: false)
            
            finishContent.title = "종료"
            finishContent.body = "다음으로 넘어가세요"
            finishContent.sound = UNNotificationSound(named: UNNotificationSoundName("다음알림.mp3"))
            
            let finishRequest = UNNotificationRequest(identifier: "fiveMins\(timeInterval)", content: finishContent, trigger: finishTrigger)
            notificationCenter.add(finishRequest)
        }
    }
    
    private func getFiveMinsNotificationTimeIntervals() -> [Int] {
        var result: [Int] = []
        
        for i in 0...self.tasks.count - 1 {
            if self.tasks[i] > 300{
                if i == 0 {
                    result.append(self.tasks[i] - 300)
                } else {
                    let sum = self.tasks[0...i].reduce(0) { $0 + $1 }
                    result.append(sum - 300)
                }
            }
        }
        
        return result
    }
    
    private func getFinishNotificationTimeIntervals() -> [Int] {
        var result: [Int] = []
        
        if self.tasks.count > 1 {
            for i in 0...self.tasks.count - 2 {
                let sum = self.tasks[0...i].reduce(0) { $0 + $1 }
                result.append(sum)
            }
        }
        
        return result
    }
    
    func tapStopButton() {
        self.isActive = false
        notificationCenter.removeAllPendingNotificationRequests()
    }
}
