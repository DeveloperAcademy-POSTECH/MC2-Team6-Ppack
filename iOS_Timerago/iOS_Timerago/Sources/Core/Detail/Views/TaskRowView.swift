//
//  TaskRowView.swift
//  iOS_Timerago
//
//  Created by yongbeomkwak on 2023/05/04.
//

import SwiftUI


struct TaskRowView: View {
    
    var routineIndex:Int
    var task:TaskModel
    @State var time:String = ""
    @State var emoji:String = ""
    @State var showError:Bool = false
    @Binding var total:Int
    
    
    
    
    
    var body: some View {
        HStack{
            
            EmojiTextField(text: $emoji)
                .font(.title3)
                .frame(width: 20,height: 20)
                .padding(7)
                .background(Circle().fill(Color.circle))

            
            
            
            TextField("Add task",text: $time)
                .font(.title3)
                .keyboardType(.numberPad)
                
        }
        .onAppear{
            emoji = task.emoji
            time = String(task.interval)
        }
        


    }
}


