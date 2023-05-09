//
//  DetailView.swift
//  iOS_Timerago
//
//  Created by yongbeomkwak on 2023/05/03.
//

import SwiftUI

enum EmojiError {
    case notEmoji
    case blank
    case noError
    case overLimit
    
    var errorMessage:String {
        
        switch self {
            
        case .notEmoji:
            return "이모지가 아닙니다."
        case .blank:
            return "잘못된 칸이 있습니다."
            
        case .noError:
            return ""
        case .overLimit:
            return "1글자를 초과했습니다."
        }
        
    }
    
}


struct DetailView: View {

    @Environment(\.dismiss) var dismiss
    @ObservedObject var vm:HomeViewModel
    @Binding var index:Int
    @State var title:String = ""
    @State var totalTime:Int = 0
    @State var tmpList:[TaskModel] = [] {
        didSet {
            pass = !(checkBlank() || checkOverInput() || checkWrongInput() || checkIsSingleEmoji())
            
           
        }
    }
    @State var error:EmojiError = .noError
    @State var pass:Bool = false
    @State var showAlert:Bool = false
    
    var body: some View {
        ZStack(alignment: .bottom){
            Color.background.ignoresSafeArea()
            
            
            
            VStack(spacing: 20){
                
                header
                    .padding(.top,10)
                    
                
                TextField("Name", text: $title)
                    .frame(maxWidth: .infinity,alignment: .leading)
                    .font(.largeTitle)
                    .bold()
                    .autocorrectionDisabled(true)
                
                
                VStack(spacing:20){
 
                        TimeView
                    
    
                        TaskListView
        
                    
                    
                }
                .padding(.top,25)
                
                
                Button {
                    
                } label: {
                    Text("Complete")
                        .font(.preB(16))
                        .foregroundColor(.white)
                        .frame(height: 55)
                        .frame(maxWidth: .infinity)
//                        .padding(.horizontal,UIScreen.width / 2 - 70)
//                        .padding(.vertical,18)
                        .background{
                            if pass {
                                LinearGradient(colors: [.gradient1,.accent], startPoint: .leading, endPoint: .trailing)
                                    
                            }
                            else {
                                Color(hex: 0xCACACA)
                                    
                            }
                            
                            
                        }
                        .cornerRadius(12)
                }
                .padding(.bottom,safeArea.bottom)

                
            }
            .padding(.horizontal,18)
        
                  
            
            
            
            
        }
        .toolbar(.hidden)
        .alert(error.errorMessage, isPresented: $showAlert, actions: {
            Button("OK",role: .cancel){
                
            }
        })
        .onAppear{
        
            tmpList = vm.routines[index].task
            title = vm.routines[index].title
            totalTime = tmpList.map{Int($0.interval)!}.reduce(0, {$0 + $1})
            UIApplication.shared.hideKeyboard()
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
                
                tmpList.append(TaskModel(emoji: .defaultEmoji, interval: ""))
    
            } label: {
                Image(systemName: "plus")
                    .foregroundColor(.blue)
                    .font(.system(size: 22))
            }

            
           

            
        }
        .padding(.horizontal,-8)
        
    }
    
    
    private var TimeView: some View {
        Text("\(String(totalTime).count > 1 ? String(totalTime) : "0\(totalTime)"  ):00")
            .font(.largeTitle)
            .bold()
            .padding(.vertical,25)
            .frame(maxWidth: .infinity)
            .padding(.horizontal,10)
            //.padding(.horizontal,UIScreen.width / 2 - 70)
            .background(
                RoundedRectangle(cornerRadius: 12)
                    .fill(.white)
            )
    }
    
    private var TaskListView: some View {
    
        List{
            ForEach($tmpList){ $task in //바인딩 , 바인딩..
                TaskRowView(task:$task)
                    .onChange(of: task) { newValue in
                            totalTime = tmpList.map{Int($0.interval) ?? 0}.reduce(0, {$0 + $1})
                        
                        pass = !(checkBlank() || checkOverInput() || checkWrongInput() || checkIsSingleEmoji())
                        
                        if newValue.emoji.count == 0  {
                            error = .blank
                            return
                        }
                        
                        if newValue.emoji.count > 1 {
                            error = .overLimit
                            showAlert = true
                            return
                            
                        }
                        
                        if !newValue.emoji.isSingleEmoji {
                            error = .notEmoji
                            showAlert = true
                            return
                            
                        }
                        
                        
                        
                        
                         
                    }
                   
            }
            
            
        }
        .listStyle(.grouped)
    }
    
    
    private func checkBlank () -> Bool {
        return tmpList.filter{$0.emoji.count == 0 || $0.interval.count == 0 }.count > 0
    }
    
    private func checkOverInput() -> Bool {
        return tmpList.filter{$0.emoji.count > 1} .count > 0
    }
    
    private func checkIsSingleEmoji() -> Bool {
        return tmpList.filter{!$0.emoji.isSingleEmoji} .count > 0
    }
    
    private func checkWrongInput() -> Bool {
        return tmpList.filter{Int($0.interval) ?? -1 <= 0 || String($0.interval.prefix(1)) == "0"}.count > 0
    }


    
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(vm: HomeViewModel(), index: .constant(0) )
    }
}


