//
//  DetailView.swift
//  iOS_Timerago
//
//  Created by yongbeomkwak on 2023/05/03.
//

import SwiftUI



struct DetailView: View {

    @Environment(\.dismiss) var dismiss
    @ObservedObject var vm:HomeViewModel
    @Binding var index:Int
    @State var title:String = ""
    @State var totalTime:Int = 0
    @State var tmpList:[TaskModel] = []

    
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
        
            tmpList = vm.routines[index].task
            title = vm.routines[index].title
            totalTime = tmpList.map{Int($0.interval)!}.reduce(0, {$0 + $1})
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
                
                tmpList.append(TaskModel(emoji: .defaultEmoji, interval: "0"))
    
            } label: {
                Image(systemName: "plus")
                    .foregroundColor(.blue)
                    .font(.system(size: 22))
            }

            
           

            
        }
        .padding(.horizontal,10)
        
    }
    
    
    private var TimeView: some View {
        Text("\(String(totalTime).count > 1 ? String(totalTime) : "0\(totalTime)"  ):00")
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
            ForEach($tmpList){ $task in //바인딩 , 바인딩..
                TaskRowView(task:$task)
                    .onChange(of: task) { _ in
                            totalTime = tmpList.map{Int($0.interval) ?? 0}.reduce(0, {$0 + $1})
                         
                    }
            }
            
            
        }
        .listStyle(.insetGrouped)
    }
    
    

    
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(vm: HomeViewModel(), index: .constant(0) )
    }
}


