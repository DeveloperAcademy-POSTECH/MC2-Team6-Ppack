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
                        UIApplication.shared.endEditing()
                    }
            }
            else {
                Text(task.emoji)
                    .font(.title3)
                    .padding(7)
                    .background(Circle().fill(Color.circle))
                    .onTapGesture {
                        showEmojiKeyboard = true
                        UIApplication.shared.endEditing()
                    }
                
            }
            
            
            
            TextField("Add task",text: $text)
                .font(.title3)
        }
        .onAppear{
            text = String(task.interval)
            print(text)
        }
    }
}


