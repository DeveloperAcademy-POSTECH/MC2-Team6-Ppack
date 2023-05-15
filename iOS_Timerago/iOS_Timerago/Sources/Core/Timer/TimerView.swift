//
//  TimerView.swift
//  iOS_Timerago
//
//  Created by yongbeomkwak on 2023/05/11.
//

import SwiftUI

struct TimerView: View {
    @ObservedObject var viewModel = TimerViewModel()
    @Environment(\.dismiss) var dismiss
    @Binding var routine: RoutineModel
    @Binding var time: Int
    @Binding var tasks: [Int]
    
    var body: some View {
        
        GeometryReader{ geometry in
            
            
            ZStack{
                
                
                
                topArea
                    .frame(height:geometry.size.height/2)
                    .position(x: geometry.size.width / 2,y: geometry.size.height/4)
                
                dismissButton
                .position(x:geometry.size.width - 27,y:20)

                
                VStack(spacing:10){
                    
                    HStack(spacing: 0){
                        ForEach(routine.task.indices){ index in
                            
                            if index == 0 {
                                Text("\(routine.task[index].emoji)")
                                    .font(.system(size: index == viewModel.currentIndex ? 35 : 24))
                                    .frame(maxWidth: .infinity)
                                
                                Spacer()
                            }
                            
                            
                            else if index == routine.task.count - 1 {
                                
                                Spacer()
                                
                                Text("\(routine.task[index].emoji)")
                                    .font(.system(size: index == viewModel.currentIndex ? 35 : 24))
                                    .frame(maxWidth: .infinity)
                                
                            }
                            
                            else {
                                
                                Spacer()
                                Text("\(routine.task[index].emoji)")
                                    .font(.system(size: index == viewModel.currentIndex ? 35 : 24))
                                    .frame(maxWidth: .infinity)
                                Spacer()
                            }
                            
                            
                            
                            
                        }
                    }
                    .frame(width:geometry.size.width,height:30)
                    .animation(.easeInOut,value:viewModel.currentIndex)
                    ZStack(alignment: .leading){
                        
                        
                        Color.white
                            .frame(width:geometry.size.width,height:20)
                        
                    
                        LinearGradient(colors: [Color(hex: 0x4E94F8),Color(hex: 0x86C6FC)], startPoint: .leading, endPoint: .trailing)
                            .frame(height: 20)
                            .frame(width:viewModel.width)

                    }
                    .shadow(color: .black.opacity(0.12), radius: 5, x: 0, y: 3)
                    
                    
                    
                    
                    
                    
                    
                }
                .position(x:geometry.size.width / 2,y:geometry.size.height/2 - 20)
                .frame(width:geometry.size.width)
                
                .zIndex(2.0)
                
                
                bottomArea
                    .frame(height:geometry.size.height/2)
                    .position(x: geometry.size.width / 2,y:geometry.size.height / 4 + geometry.size.height / 2)
            }
                
                
               


            
            
            
        }
        .preferredColorScheme(.dark)
        .onAppear{
            viewModel.totalWidth = UIScreen.width
            viewModel.minutes = Double(self.time) * 60
            viewModel.totalTime = Double(self.time) * 60
            viewModel.tasks = self.tasks
            viewModel.isActive.toggle()
            viewModel.start()
            viewModel.setTasksNotification()
            viewModel.registerNotification()
        }
        
        .onReceive(NotificationCenter.default.publisher(for: UIApplication.willResignActiveNotification)) { _ in
            viewModel.isActive = false
            viewModel.backgroundTime = Date()
        }
        .onReceive(NotificationCenter.default.publisher(for: UIApplication.didBecomeActiveNotification)) { _ in
            if let backgroundTime = viewModel.backgroundTime {
                let timeInterval = Date().timeIntervalSince(backgroundTime)
                let currentTime = viewModel.minutes - timeInterval
                let width = (CGFloat(viewModel.totalWidth) / viewModel.totalTime)
                
                viewModel.timeInterval = Int(timeInterval)
                viewModel.totalTimeDifference += timeInterval
               
                if currentTime >= 0 {
                    withAnimation(.default) {
                        viewModel.minutes = currentTime
                        viewModel.width = 0
                        viewModel.width = width * (viewModel.totalTime - viewModel.minutes)
                        print("NewValue\(width * (viewModel.totalTime - viewModel.minutes))")
                    }
                }
                if viewModel.minutes < timeInterval {
                    viewModel.width = viewModel.totalWidth
                }
            }
            viewModel.isActive = true
        }
        .onReceive(NotificationCenter.default.publisher(for: UIScene.didDisconnectNotification)) { _ in
            viewModel.tapStopButton()
        }
    }
    
    private var topArea: some View {
        ZStack{
            Color.black.ignoresSafeArea()
            
            Text(viewModel.getTimeString(time: Double(self.time * 60)))
                .font(.j500B(90))
                .foregroundColor(.white)
            
            
            
        }
    }
    
    
    private var dismissButton: some View {
        Button {
            dismiss()
            viewModel.tapStopButton()
        } label: {
            Image(systemName: "xmark")
                .font(.title2)
                .foregroundColor(.white)
        }
    }
    
    private var bottomArea: some View {
        ZStack(alignment:.bottom){
            
            Color.background.ignoresSafeArea()
            
            
            Text("\(routine.task[viewModel.currentIndex].emoji)")
                .font(.system(size: 78))
                .padding(38)
                .animation(.easeInOut, value: viewModel.currentIndex)
                .background(
                    Circle()
                        .fill(
                            LinearGradient(colors: [Color(hex: 0xCAE3FF),Color(hex: 0xB4D8FE)], startPoint: .top, endPoint: .bottom)
                        )
                       
              
                )
                .padding(18)
                .background(
                    Circle()
                        .fill(Color(hex: 0x4E94F8,alpha: 0.09))

                )
                
                .padding(.bottom,UIScreen.height/10)
                
                
            

            
            
        }
    }
}
