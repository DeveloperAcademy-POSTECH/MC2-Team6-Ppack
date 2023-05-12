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
    @Binding var routine:RoutineModel
    @State var title:String = ""
    @State var totalTime:Int = 0
    @State var tmpList:[TaskModel] = [] {
        didSet {
            pass = isPassAllRequire()
            
            totalTime = tmpList.map{Int($0.interval) ?? 0}.reduce(0, {$0 + $1})
            
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
                    
                
                TextField("타이머 이름", text: $title)
                    .frame(maxWidth: .infinity,alignment: .leading)
                    .font(.largeTitle)
                    .bold()
                    .autocorrectionDisabled()
                    
                
                
                VStack(spacing:5){
 
                       
                    
                    if tmpList.isEmpty {
                        Spacer()
                        Text("시간을 입력하세요")
                            .font(.preM(18))
                            .foregroundColor(.black.opacity(0.5))
                        Spacer()
                    }
                    else {
                        TaskListView
                    }
                        
        
                    
                    
                }
                .padding(.top,25)
                
                TimeView
                
                Button {
                    var finalRoutine = RoutineModel(id: routine.id, task: tmpList, title: title)
                    vm.addOrUpdate(routine: finalRoutine)
                    dismiss()
                    routine = finalRoutine
                    
                } label: {
                    Text("타이머 추가하기")
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
                .disabled(!pass)
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
        
            tmpList = routine.task
            title = routine.title
            
            
            if tmpList.filter({$0.interval == ""}).count == 0 {
                totalTime = tmpList.map{Int($0.interval)!}.reduce(0, {$0 + $1})
            }
            
            
            UIApplication.shared.hideKeyboard()
        }
        .onChange(of: title) { newValue in
            pass = isPassAllRequire()
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
                        .font(.preM(17))
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
            .font(.j500B(40))
            .padding(.vertical,25)
            .frame(maxWidth: .infinity)
            .padding(.horizontal,10)
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
                        
                        pass = isPassAllRequire()

                        
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
            .onDelete { indexSet in
                tmpList.remove(atOffsets: indexSet)
            }
            .onMove { from, to in
                tmpList.move(fromOffsets: from, toOffset: to)
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

    private func isPassAllRequire() -> Bool {
        return !(checkBlank() || checkOverInput() || checkWrongInput() || checkIsSingleEmoji() || tmpList.isEmpty || title.isEmpty)
    }

    
}




