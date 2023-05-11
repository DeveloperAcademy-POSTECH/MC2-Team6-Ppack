//
//  TimerView.swift
//  iOS_Timerago
//
//  Created by yongbeomkwak on 2023/05/11.
//

import SwiftUI

struct TimerView: View {
    
    @Binding var routine:RoutineModel
    @State var time:String = ""
    
    var body: some View {
        
        VStack(spacing:0){
            
            topArea
            bottomArea
            
            
        }
        .onAppear{
            time = String(routine.task.map{Int($0.interval) ?? 0}.reduce(0, {$0 + $1}))
        }
        
        
    }
    
    private var topArea: some View {
        ZStack{
            Color.black.ignoresSafeArea()
            
            Text("\(time):00")
                .font(.j500B(90))
                .foregroundColor(.white)
                
            
            
        }.frame(height: UIScreen.height/2)
    }
    
    private var bottomArea: some View {
        ZStack(alignment:.bottom){
            
            Color.background.ignoresSafeArea()
            
            Button {
                
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

            
        }.frame(height: UIScreen.height/2)
    }
}

struct TimerView_Previews: PreviewProvider {
    static var previews: some View {
        TimerView(routine: .constant(RoutineModel(task: [TaskModel(emoji: "✅", interval: "5"),TaskModel(emoji: "✅", interval: "10"),TaskModel(emoji: "✅", interval: "5"),TaskModel(emoji: "✅", interval: "20")], title: "Hello")))
            .previewLayout(.sizeThatFits)
    }
}
