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
    
    
    var body: some View {
        HStack{
            
            EmojiTextField(text: $task.emoji)
                .font(.title3)
                .frame(width: 20,height: 20)
                .padding(7)
                .background(Circle().fill(Color.circle))
                .keyboardShortcut(.return)
                .keyboardShortcut(.cancelAction)

                

            
            
            
            TextField("Add task",text: $task.interval)
                .font(.title3)
                .keyboardType(.numberPad)
                .keyboardShortcut(.return)
                .keyboardShortcut(.cancelAction)
                
                
        }

        


    }
}


