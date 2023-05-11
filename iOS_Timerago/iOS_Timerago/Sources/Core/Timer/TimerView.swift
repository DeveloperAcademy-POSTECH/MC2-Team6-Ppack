//
//  TimerView.swift
//  iOS_Timerago
//
//  Created by yongbeomkwak on 2023/05/11.
//

import SwiftUI

struct TimerView: View {
    
    @Environment(\.dismiss) var dismiss
    @Binding var routine:RoutineModel
    @State var time:String = ""
    @State var width:CGFloat = 0
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        
        GeometryReader{ geometry in
            
            ZStack{
                topArea
                    .frame(height:geometry.size.height/2)
                    .position(x: geometry.size.width / 2,y: geometry.size.height/4)
                
                VStack(spacing:10){
                    
                    HStack(spacing:0){
                        ForEach(routine.task){ task in
                            
                            Text("\(task.emoji)")
                                .font(.system(size: 24))
                                .frame(maxWidth: .infinity)
                            
                        }
                    }
                    .frame(width:.infinity,height:30,alignment: .leading)
                    
                    RoundedRectangle(cornerRadius:12)
                        .fill(Color.white)
                        .frame(width:.infinity,height:20)
                        .padding(.horizontal,20)
                        .overlay(alignment:.leading){
                            RoundedRectangle(cornerRadius:12)
                                .fill(Color.accent)
                                .frame(width:width)
                                .padding(.horizontal,20)
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
            time = String(routine.task.map{Int($0.interval) ?? 0}.reduce(0, {$0 + $1}))
        }
        
        .onReceive(timer) { _ in
            withAnimation(.easeInOut){
                width += 1
            }
        }
        
        
        
    }
    
    private var topArea: some View {
        ZStack{
            Color.black.ignoresSafeArea()
            
            Text("\(time):00")
                .font(.j500B(90))
                .foregroundColor(.white)
                
            
            
        }
    }
    
    private var bottomArea: some View {
        ZStack(alignment:.bottom){
            
            Color.background.ignoresSafeArea()
            
            Button {
                dismiss()
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

struct TimerView_Previews: PreviewProvider {
    static var previews: some View {
        TimerView(routine: .constant(RoutineModel(task: [TaskModel(emoji: "✅", interval: "5"),TaskModel(emoji: "✅", interval: "10"),TaskModel(emoji: "✅", interval: "5"),TaskModel(emoji: "✅", interval: "20"),TaskModel(emoji: "✅", interval: "20"),TaskModel(emoji: "✅", interval: "20")], title: "Hello")))
            .previewLayout(.sizeThatFits)
    }
}
