//
//  TaskRowView.swift
//  iOS_Timerago
//
//  Created by yongbeomkwak on 2023/05/04.
//

import SwiftUI


struct TaskRowView: View {
    
    var task:TaskModel
    @State var text:String = "" {
        didSet{
            
        }
    }
    @State var emoji:String = ""
    @State var showError:Bool = false
    
    
    
    
    var body: some View {
        HStack{
            if emoji.isEmpty {
                Image(systemName: "face.smiling.inverse")
                    .renderingMode(.template)
                    .foregroundColor(.white)
                    .font(.title3)
                    .frame(width: 20,height: 20)
                    .padding(7)
                    .background(Circle().fill(Color.circle))
            }
            else {
                EmojiTextField(text: $emoji)
                    .font(.title3)
                    .frame(width: 20,height: 20)
                    .padding(7)
                    .background(Circle().fill(Color.circle))
                    

                
            }
            
            
            
            TextField("Add task",text: $text)
                .font(.title3)
                .keyboardType(.namePhonePad)
        }
        .onAppear{
            emoji = task.emoji
            text = String(task.interval)
        }


    }
}


