//
//  DetailView.swift
//  iOS_Timerago
//
//  Created by yongbeomkwak on 2023/05/03.
//

import SwiftUI
import MaterialShowcase

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

enum ShowCaseStep {
    case addButton
    case title
    case list
    case totalTime
    
    
    
    
    var headerText:String {
        switch self {

        case .addButton:
            return "추가 버튼"
        case .title:
            return "타이머 제목"
        case .list:
            return "할 일 목록"
        case .totalTime:
            return "총 시간"
        }
    }
    
    var description:String {
        switch self {

        case .addButton:
            return "클릭하여 할 일을 추가해주세요."
        case .title:
            return "타이머 제목을 설정해주세요."
        case .list:
            return "할 일에 해당하는 이모티콘과 분을 입력해주세요.\n스와이프를 통한 삭제와 롱탭을 통한 순서변경이 가능합니다."
        case .totalTime:
            return "타이머의 총 시간이 표시됩니다."
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
    @State private var rectAddButton = CGRect()
    @State private var rectTitle = CGRect()
    @State private var rectTaskList = CGRect()
    @State private var rectTotalTime = CGRect()
    @State private var showCaseStep:ShowCaseStep = .addButton
    
    @State private var showOnBoard:Bool = false
    
    
    var body: some View {
        GeometryReader { proxy in
            ZStack(alignment: .bottom){
                Color.background.ignoresSafeArea()
                
                
                
                VStack(spacing: 20){
                    
                    header
                        .padding(.top,10)
                    
                    VStack(spacing:0){
                        
                        secondaryHeader
                        
                        
                    
                        VStack(spacing:5){
         
                            
                            
                            if tmpList.isEmpty {
                                Spacer()
                                Text("태스크를 추가해주세요")
                                    .font(.preR(18))
                                    .foregroundColor(.init(hex: 0x545454,alpha: 0.5))
                                Spacer()
                            }
                            else {
                                taskListView
                                

                                    
                            }
          
                            
                        }
                    }
                    
                    
                    timeView
                    
                    
                    Button {
                        var finalRoutine = RoutineModel(id: routine.id, task: tmpList, title: title)
                        vm.addOrUpdate(routine: finalRoutine)
                        dismiss()
                        routine = finalRoutine
                        
                    } label: {
                        Text("완료")
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
                    .padding(.bottom,safeArea.bottom == .zero ? 34 : safeArea.bottom )

                    
                }
                .padding(.horizontal,18)
            
                      

                
            }
            .toolbar(.hidden)
            .alert(error.errorMessage, isPresented: $showAlert, actions: {
                Button("OK",role: .cancel){
                    
                }
            })
            .onAppear{
                
                let tmp:[Bool] = PreferenceManager.firstApproach ?? [true]
                if let flag = tmp.first {
                    
                    showOnBoard = flag
                    
                    PreferenceManager.shared.addRecentState(bool: [false])
                    
                }
                
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
        .sheet(isPresented: $showOnBoard) {
            onBoard
            .frame(maxWidth: .infinity,maxHeight: .infinity)
            //.background(Color.black.opacity(0.4))
            

            
                
        }

    
        
        
        
    }
    

}

extension DetailView{
    
    //MARK: View
    
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
                    
                    Text("타이머")
                        .font(.preR(17))
                        .foregroundColor(.blue)
                }
            }
            
            
            
            
                
            
            Spacer()
            
            Button {
                showOnBoard = true
            } label: {
                Image(systemName: "info.circle")
                    .foregroundColor(Color(hex: 0x636366))
                    .font(.system(size: 22))
                    
            }
            .padding(.trailing,5)
            

            
           

            
        }
        .padding(.horizontal,-8)
        
    }
    
    private var secondaryHeader: some View {
        HStack(alignment:.firstTextBaseline){
            TextField("이름을 지어주세요", text: $title)
                .frame(maxWidth: .infinity,alignment: .leading)
                .font(.largeTitle)
                .bold()
                .autocorrectionDisabled()
            Spacer()
            Button {
                tmpList.append(TaskModel(emoji: .defaultEmoji, interval: ""))
            } label: {
                Text("추가")
                
            }
            
        }
    }

    private var timeView: some View {
        
        HStack{
        
            Text("총합계")
                .font(.preB(12))
                .padding(.vertical,8)
                .padding(.horizontal,17)
                .foregroundColor(Color(hex: 0x6F6F6F))
                .background(
                    RoundedRectangle(cornerRadius: 8)
                        .fill(Color(hex: 0x818181,alpha: 0.15))
                )
            
            Spacer()
        
            Text("\(String(totalTime))분")
                .font(.j500B(40))
        }
        .padding(.vertical,25)
        .padding(.horizontal,30)
        .frame(maxWidth: .infinity)

        
        
            
            
    }
    
    private var taskListView: some View {
    
        List{
            ForEach($tmpList){ $task in //바인딩 , 바인딩..
                TaskRowView(task:$task)
                    .onChange(of: task) { newValue in
                        totalTime = tmpList.map{Int($0.interval) ?? 0}.reduce(0, {$0 + $1})
                        
                        pass = isPassAllRequire()

                         
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
    
    private var onBoard: some View {
        ZStack{
            Color.background.ignoresSafeArea()
            
            Color.black.opacity(0.4).ignoresSafeArea()
            
            Image("Onboard")
                .resizable()
                .scaledToFit()
        }
    }
    
    
    //MARK: Function
    
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
        return !(checkBlank() || checkOverInput() || checkWrongInput()  || tmpList.isEmpty || title.isEmpty)
    }

    
    func startShowcase(_ rect: CGRect) {
        // Start Help Tour
        let showcase = MaterialShowcase()
        let uiview = UIView()
        uiview.frame = rect
        uiview.layer.cornerRadius = 45
        uiview.backgroundColor = .clear
        uiview.tintColor = UIColor(Color.accent) // 쇼케이스 색깔 변경
        
        showcase.backgroundPromptColorAlpha = 0.9
        showcase.setTargetView(view: uiview)
        
        showcase.primaryText = showCaseStep.headerText
        showcase.primaryTextFont = UIFont(name: "Pretendard-Bold", size: 20)
        
        showcase.secondaryText = showCaseStep.description
        showcase.secondaryTextFont = UIFont(name: "Pretendard-Medium", size: 14)
        
        showcase.show(completion: {

        })
        
        
    }
    
}

struct GeometryGetterMod: ViewModifier {
    @Binding var rect: CGRect
    func body(content: Content) -> some View {
        return GeometryReader { (g) -> Color in
            DispatchQueue.main.async { // to avoid warning
                self.rect = g.frame(in: .global)
            }
            return Color.clear
        }
    }
}
