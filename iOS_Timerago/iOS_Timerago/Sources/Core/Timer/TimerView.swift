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
    @State var width: CGFloat =  0
    var totalWidth:CGFloat = UIScreen.width
    
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    

    
    var body: some View {
        
        GeometryReader{ geometry in
            
            
            ZStack{
                topArea
                    .frame(height:geometry.size.height/2)
                    .position(x: geometry.size.width / 2,y: geometry.size.height/4)
                
                VStack(spacing:10){
                    
                    HStack(spacing: 0){
                        ForEach(routine.task.indices){ index in
                            
                            if index == 0 {
                                Text("\(routine.task[index].emoji)")
                                    .font(.system(size: 24))
                                    .frame(maxWidth: .infinity)
                                Spacer()
                            }
                            
                            
                            else if index == routine.task.count - 1 {
                                
                                Spacer()
                                
                                Text("\(routine.task[index].emoji)")
                                    .font(.system(size: 24))
                                    .frame(maxWidth: .infinity)
                                
                            }
                            
                            else {
                                
                                Spacer()
                                Text("\(routine.task[index].emoji)")
                                    .font(.system(size: 24))
                                    .frame(maxWidth: .infinity)
                                Spacer()
                            }
                                
                            
                                
                            
                        }
                    }
                    .frame(width:geometry.size.width,height:30)
                   
                    
                    RoundedRectangle(cornerRadius:12)
                        .fill(Color.white)
                        .frame(width:geometry.size.width - 40,height:20)
                        .overlay(alignment:.leading){
                            RoundedRectangle(cornerRadius:12)
                                .fill(Color.accent)
                                .frame(width:width)
                        }
                        .shadow(color: .black.opacity(0.12), radius: 5, x: 0, y: 3)

                    
                    
                    
                    
                    
                }
                .position(x:geometry.size.width / 2,y:geometry.size.height/2 - 20)
                .frame(width:geometry.size.width)
                
                .zIndex(2.0)
                

                bottomArea
                    .frame(height:geometry.size.height/2)
                    .position(x: geometry.size.width / 2,y:geometry.size.height / 4 + geometry.size.height / 2 )
            }
                
                
               


            
            
            
        }
        .onAppear{
            viewModel.minutes = Double(self.time) * 60
            viewModel.tasks = self.tasks
            viewModel.isActive.toggle()
            viewModel.countdownArrayElements()
            viewModel.start()
            viewModel.setTasksNotification()
            viewModel.registerNotification()
            
        }
        
        .onReceive(timer) {  _ in
            withAnimation(.easeInOut){
                width += (CGFloat(totalWidth - 40) / (Double(self.time) * 60))
            }
        }
        .onReceive(NotificationCenter.default.publisher(for: UIApplication.willResignActiveNotification)) { _ in
            viewModel.backgroundTime = Date()
        }
        .onReceive(NotificationCenter.default.publisher(for: UIApplication.willEnterForegroundNotification)) { _ in
            if let backgroundTime = viewModel.backgroundTime {
                let timeInterval = Date().timeIntervalSince(backgroundTime)
                viewModel.timeInterval += Int(timeInterval)
            }
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
    
    private var bottomArea: some View {
        ZStack(alignment:.bottom){
            
            Color.background.ignoresSafeArea()
            
            Button {
                dismiss()
                viewModel.tapStopButton()
            } label: {
                Image(systemName: "stop.fill")
                    .font(.largeTitle)
                    .foregroundColor(.accent)
                    .padding(30)
                    .background(
                    Circle()
                        .fill(Color.white)
                        .shadow(color:.black.opacity(0.1),radius: 5,x: 0,y: 4)
                        
                          
                    )
                    
            }.padding(.bottom,UIScreen.height/6)

            
        }
    }
}
