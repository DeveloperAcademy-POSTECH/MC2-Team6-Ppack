//
//   RoutineCardView.swift
//  iOS_Timerago
//
//  Created by yongbeomkwak on 2023/05/01.
//

import SwiftUI

struct RoutineCardView: View {
    
    
    @Binding var routine:RoutineModel
    @State var showTimer:Bool = false
    
    var body: some View {

        ZStack{
            
            VStack(alignment: .leading,spacing: 23){
                Text("\(routine.title)").font(.preB(21))
                    
                    
                
                HStack(spacing:14){
                    Text("\(routine.task.map{Int($0.interval)!}.reduce(0, {$0 + $1}))m").font(.preM(14))
                    
                    Rectangle()
                        .frame(maxWidth: 1,maxHeight: 20)
                        .opacity(0.5)
                    
                
                    ForEach(routine.task){ task   in
                        Text(task.emoji)
                            .font(.system(size: 14))
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
                    showTimer.toggle()
                }
        }
        .fullScreenCover(isPresented: $showTimer) {
            TimerView(routine: $routine)
        }
        
     
        
    }
}

