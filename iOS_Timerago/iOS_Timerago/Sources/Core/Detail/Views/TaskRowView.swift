//
//  TaskRowView.swift
//  iOS_Timerago
//
//  Created by yongbeomkwak on 2023/05/04.
//

import SwiftUI
import Combine

struct TaskRowView: View {
    
    @Binding var task:TaskModel
    @FocusState var isTimeFocused:Bool
    @State var showEmojiView:Bool = false
    
    var body: some View {
        
        let timeText = Binding<String>(
                get: {
                    if isTimeFocused {
                       return task.interval.isEmpty ? "" : "\(task.interval)"
                    } else {
                       return  task.interval.isEmpty ? "" : "\(task.interval)분"
                    }
                    
                },
                set: { text in
                    let text = text.replacingOccurrences(of: "분", with: "")
                    task.interval = text
                    
                }
            )
        
        
        
        HStack{
            
            Text(task.emoji)
                .font( task.emoji == .defaultEmoji ?  .system(size: 20) : .system(size: 15))
                .foregroundColor(.white)
                .frame(width: 20,height: 20)
                .padding(7)
                .background{
                    
                    if  task.emoji == .defaultEmoji  {
                        Circle().fill(Color(hex: 0xD0D3DA))
                    }
                    else {
                        Circle().fill(LinearGradient(colors: [Color(hex: 0xE3F0FF),Color(hex: 0xB2D3FF)], startPoint: .top, endPoint: .bottom))
                    }

                        
                           

                }
                .onTapGesture {
                    showEmojiView = true
                }
                


                
            
            TextField("몇 분 걸리는 일인가요?",text: timeText)
                .font(.preR(18))
                .keyboardType(.numberPad)
                .keyboardShortcut(.return)
                .keyboardShortcut(.cancelAction)
                .focused($isTimeFocused)
      
                
        }
        .sheet(isPresented: $showEmojiView) {
            EmojiPopUpView(str: $task.emoji)
                .presentationDetents([.fraction(0.4)])
              
        }

        


    }
}


