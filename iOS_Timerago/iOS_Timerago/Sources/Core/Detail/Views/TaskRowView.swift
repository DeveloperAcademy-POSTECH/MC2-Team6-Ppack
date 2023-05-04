//
//  TaskRowView.swift
//  iOS_Timerago
//
//  Created by yongbeomkwak on 2023/05/04.
//

import SwiftUI


struct TaskRowView: View {
    
    @Binding var showEmojiKeyboard:Bool
    var task:TaskModel
    @State var text:String = ""
    
    init(showEmojiKeyboard: Binding<Bool>, task: TaskModel) {
        self._showEmojiKeyboard = showEmojiKeyboard
        self.task = task
        self.text = String(task.interval)
    }
    
    
    
    
    var body: some View {
        HStack{
            if task.emoji.isEmpty {
                Image(systemName: "face.smiling.inverse")
                    .renderingMode(.template)
                    .foregroundColor(.white)
                    .font(.title3)
                    .padding(7)
                    .background(Circle().fill(Color.circle))
                    .onTapGesture {
                        showEmojiKeyboard = true
                    }
            }
            else {
                Text(task.emoji)
                    .font(.title3)
                    .padding(7)
                    .background(Circle().fill(Color.circle))
                    .onTapGesture {
                        showEmojiKeyboard = true
                    }
                
            }
            
            
            
            TextField("Add task",text: $text)
                .font(.title3)
        }
    }
}


