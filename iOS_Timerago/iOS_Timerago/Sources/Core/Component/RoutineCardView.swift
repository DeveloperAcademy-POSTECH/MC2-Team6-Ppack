//
//   RoutineCardView.swift
//  iOS_Timerago
//
//  Created by yongbeomkwak on 2023/05/01.
//

import SwiftUI

struct RoutineCardView: View {
    
    @StateObject var viewModel = RoutineCardViewModel()
    @Binding var routine:RoutineModel
    
    
    var body: some View {
        
        ZStack{
            
            VStack(alignment: .leading,spacing: 23){
                Text("\(routine.title)").font(.preB(21))
                
                
                
                HStack(spacing:14){
                    Text("\(routine.task.map{Int($0.interval)!}.reduce(0, {$0 + $1}))분").font(.preR(14))
                    
                    Rectangle()
                        .frame(maxWidth: 1,maxHeight: 20)
                        .opacity(0.5)
                    
                    
                    if routine.task.count > 5 {
                        ForEach((0..<5)){ index in
                            Text(routine.task[index].emoji)
                                .font(.system(size: 14))
                        }
                    }
                    else
                    {
                        ForEach(routine.task){ task   in
                            Text(task.emoji)
                                .font(.system(size: 14))
                        }
                    }
                    
                    
                    
                }
                
                
            }
            .frame(maxWidth: .infinity,alignment: .leading)
            .padding(.leading,5)
            .padding(.top,20)
            .padding(.bottom,25)
            
            PlayButton()
                .frame(maxWidth: .infinity,alignment: .trailing).padding()
                .onTapGesture {
                    var intervals: [String] = []
                    viewModel.tasks = self.routine.task
                    self.routine.task.forEach { intervals.append( $0.interval ) }
                    viewModel.intervals = intervals
                    viewModel.showingSheet.toggle()
                
                }
                .fullScreenCover(isPresented: $viewModel.showingSheet) {
                    TimerView(routine: $routine,time: $viewModel.time, tasks: $viewModel.taskTime)
                }
            
        }
        
        
        
    }
}

