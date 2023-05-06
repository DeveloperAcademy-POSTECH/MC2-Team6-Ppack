//
//  DetailView.swift
//  iOS_Timerago
//
//  Created by yongbeomkwak on 2023/05/03.
//

import SwiftUI

struct DetailLoadingView : View {
    
    @Binding var routine: RoutineModel?
    
    var body: some View {
        ZStack{
            if let routine = routine {
                DetailView(routine: routine)
            }
        }
    }
}

struct DetailView: View {
    
    @Environment(\.dismiss) var dismiss

    @StateObject var vm:DetailViewModel
    @State var text:String = ""
   
    init(routine:RoutineModel){
        _vm = StateObject(wrappedValue: DetailViewModel(routine: routine))
        
    }
    
    var body: some View {
        ZStack(alignment: .bottom){
            Color.background.ignoresSafeArea()
            
            
            
            VStack(spacing: 20){
                
                header
                    .padding(.top,10)
                    
                
                TextField("Name", text: $vm.title)
                    .frame(maxWidth: .infinity,alignment: .leading)
                    .padding(.horizontal,16)
                    .font(.largeTitle)
                    .bold()
                
                
                VStack(spacing:0){
 
                       totalTime
                    
    
                        taskList
        
                    
                    
                }
                .padding(.top,25)
                
            }
        
                        
            
        }
        .toolbar(.hidden)
        
    }
    

}

extension DetailView{
    private var header: some View {
        
        HStack{
            
            HStack(spacing:5){
                Image(systemName: "chevron.left")
                    .font(.system(size: 22))
                    .foregroundColor(.blue)
                    //.bold()
                
                Text("Timers")
                    .font(.preB(17))
                    .foregroundColor(.blue)
            }
            .onTapGesture {
                dismiss()
            }
            
                
            
            Spacer()
            
            Image(systemName: "plus")
                .foregroundColor(.blue)
                .font(.system(size: 22))
                .onTapGesture {
                    vm.routine.task.append(TaskModel(emoji: "", interval: 0))
                }
            
        }
        .padding(.horizontal,10)
        
    }
    
    
    private var totalTime: some View {
        Text("00:00")
            .font(.largeTitle)
            .bold()
            .padding(.vertical,25)
            .padding(.horizontal,UIScreen.width / 2 - 70)
            .background(
                RoundedRectangle(cornerRadius: 12)
                    .fill(.white)
            )
    }
    
    private var taskList: some View {
        List{
            ForEach(vm.routine.task){ task in
                TaskRowView(task: task)
            }
            
        }
        .listStyle(.insetGrouped)
    }
    

    
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(routine: RoutineModel(id: UUID().uuidString, task: [TaskModel(emoji: "", interval: 0)], title: "", totalTime: 0))
    }
}


