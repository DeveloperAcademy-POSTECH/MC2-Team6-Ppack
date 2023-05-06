//
//  DetailView.swift
//  iOS_Timerago
//
//  Created by yongbeomkwak on 2023/05/03.
//

import SwiftUI



struct DetailView: View {
    
    @Environment(\.dismiss) var dismiss
    @Binding var routine:RoutineModel
    @State var title:String = ""
    @State var totalTime:Int = 0
    @State var tasks:[TaskModel] = []

    
    var body: some View {
        ZStack(alignment: .bottom){
            Color.background.ignoresSafeArea()
            
            
            
            VStack(spacing: 20){
                
                header
                    .padding(.top,10)
                    
                
                TextField("Name", text: $title)
                    .frame(maxWidth: .infinity,alignment: .leading)
                    .padding(.horizontal,16)
                    .font(.largeTitle)
                    .bold()
                
                
                VStack(spacing:0){
 
                        TimeView
                    
    
                        TaskListView
        
                    
                    
                }
                .padding(.top,25)
                
            }
        
                        
            
        }
        .toolbar(.hidden)
        .onAppear{
            title = routine.title
            tasks = routine.task
            totalTime = routine.totalTime
        }
        
    }
    

}

extension DetailView{
    private var header: some View {
        
        HStack{
            
            Button(action: {
                dismiss()
            }) {
                HStack(spacing:5){
                    
                    
                    Image(systemName: "chevron.left")
                        .font(.system(size: 22))
                        .foregroundColor(.blue)
                        //.bold()
                    
                    Text("Timers")
                        .font(.preB(17))
                        .foregroundColor(.blue)
                }
            }
            
            
            
            
                
            
            Spacer()
            
            Button {
                tasks.append(TaskModel(emoji: .defaultEmoji, interval: 0))
            } label: {
                Image(systemName: "plus")
                    .foregroundColor(.blue)
                    .font(.system(size: 22))
            }

            
           

            
        }
        .padding(.horizontal,10)
        
    }
    
    
    private var TimeView: some View {
        Text("\(totalTime):00")
            .font(.largeTitle)
            .bold()
            .padding(.vertical,25)
            .padding(.horizontal,UIScreen.width / 2 - 70)
            .background(
                RoundedRectangle(cornerRadius: 12)
                    .fill(.white)
            )
    }
    
    private var TaskListView: some View {
    
        List{
            ForEach(tasks){ task in
                TaskRowView(task: task)
            }
            
        }
        .listStyle(.insetGrouped)
    }
    

    
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(routine: .constant(RoutineModel(id: UUID().uuidString, task: [TaskModel(emoji: "", interval: 0)], title: "", totalTime: 0)))
    }
}


