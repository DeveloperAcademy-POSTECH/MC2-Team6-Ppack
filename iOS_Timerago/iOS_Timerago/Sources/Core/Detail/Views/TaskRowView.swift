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
    @FocusState var isFocus:Bool
    
    
    var body: some View {
        
        let text = Binding<String>(
                get: {
                    if isFocus {
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
            
            EmojiTextField(text: $task.emoji)
                .font(.title3)
                .frame(width: 20,height: 20)
                .padding(7)
                .background(Circle().fill(Color.circle))
                .keyboardShortcut(.return)
                .keyboardShortcut(.cancelAction)

                
            
            TextField("시간을 입력해주세요",text: text)
                .font(.preR(18))
                .keyboardType(.numberPad)
                .keyboardShortcut(.return)
                .keyboardShortcut(.cancelAction)
                .focused($isFocus)
            
            
            
            
                
                
        }

        


    }
}


