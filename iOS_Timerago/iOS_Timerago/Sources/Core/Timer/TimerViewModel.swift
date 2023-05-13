//
//  TimerViewModel.swift
//  backgroundTimerPractice
//
//  Created by 송기원 on 2023/05/03.
//

import Foundation
import UserNotifications

final class TimerViewModel: ObservableObject {
    @Published var isActive = false
    @Published var minutes: Double = 0.0
    @Published var tasks: [Int] = []
    @Published var backgroundTime: Date? = nil
    @Published var timeInterval: Int = 0 {
        didSet {
            if self.minutes > Double(self.timeInterval) {
                self.minutes -= Double(self.timeInterval)
            } else {
                isActive = false
                self.minutes = 0.1
            }
            
            if self.taskTime > self.timeInterval {
                self.taskTime -= self.timeInterval
            } else {
                self.taskTime = self.getTaskTime(timeInterval: timeInterval)
            }
            print(timeInterval)
        }
    }
    private let notificationCenter = UNUserNotificationCenter.current()
    private var taskTime = 0
    private var currentIndex = 0
    
    func start() {
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { Timer in
            guard self.isActive != false else { return }
           
            if self.minutes > 0 {
                self.minutes -= 1
            } else if self.minutes == 0 {
                MusicPlayManager.shared.playSound(name: "타임오버")
                Timer.invalidate()
            }
        })
        
    }
    
    func getTimeString(time: Double) -> String {
        let minutes = Int(self.minutes) / 60
        let seconds = Int(self.minutes) % 60
        
        return String(format: "%02i:%02i", minutes, seconds)
    }
    
    private func countdown(completion: @escaping () -> Void) {
        if currentIndex == self.tasks.count {
            self.isActive = false
        }
        
        guard self.taskTime > 0 else {
            completion()
            return
        }
        
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { [weak self] Timer in
            guard let self = self else { return }
            guard self.isActive != false else { return }
            
            self.taskTime -= 1
           
            if self.taskTime == 40 {
                MusicPlayManager.shared.playSound(name: "5분알림")
            } else if self.taskTime == 0 {
                self.countdown(completion: completion)
                Timer.invalidate()
            }
            if self.minutes == 0.1 {
                Timer.invalidate()
            }
        })
    }
    
    func countdownArrayElements() {
        self.taskTime = self.tasks[currentIndex]
        countdown() {
            self.currentIndex += 1
            
            if self.currentIndex < self.tasks.count {
                self.countdownArrayElements()
                MusicPlayManager.shared.playSound(name: "다음알림")
            }
        }
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
            print(finishRequest)
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
    
    private func getTaskTime(timeInterval: Int) -> Int {
        guard currentIndex < self.tasks.count - 1 else { return 0 }
        
        var time = timeInterval
        self.currentIndex += 1
        time -= self.taskTime
        
        while self.tasks[self.currentIndex] < time {
            time = time - self.tasks[currentIndex]
            currentIndex += 1
        }
        let result = self.tasks[currentIndex] - time
        
        return result
    }
    
    func tapStopButton() {
        self.isActive = false
        notificationCenter.removeAllPendingNotificationRequests()
    }
}
