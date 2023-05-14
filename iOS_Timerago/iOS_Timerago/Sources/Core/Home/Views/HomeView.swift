//
//  HomeView.swift
//  iOS_Timerago
//
//  Created by yongbeomkwak on 2023/05/01.
//

import SwiftUI

struct HomeView: View {

@ObservedObject private var vm:HomeViewModel = HomeViewModel()
@State var isPresented:Bool = false

@State private var selectedRoutine:RoutineModel = RoutineModel(task: [TaskModel(emoji: .defaultEmoji, interval: "")], title: "")

@State private var showIntro:Bool = true


var body: some View {
    
    ZStack{
        if showIntro {
            LaunchView().onAppear{
                
                DispatchQueue.main.asyncAfter(deadline: .now()+3){
                    
                    withAnimation(.easeOut){
                        showIntro.toggle()
                    }
                    
                }
                
            }
            
        }
        else {
            ZStack{
                
                
                Color.background.ignoresSafeArea()
                
                
                if $vm.routines.isEmpty {
                    

                    Text("앗! 타이머가 아직 없어요🥲")
                        .font(.preB(18))
                        .foregroundColor(.init(hex: 0x545454,alpha: 0.5))
                        .padding(.bottom,UIScreen.height/6)
                        
                    
                
                }
                else {
                    List{
                        ForEach($vm.routines) { $rotuine in
                            RoutineCardView(routine: $rotuine)
                                .contentShape(Rectangle()) // 행 전체 클릭시 바로 재생되기 위해
                                .onTapGesture {
                                    
                                    selectedRoutine = rotuine
                                    
                                    isPresented.toggle()
                                }
                            
                        }
                        .onDelete { indexSet in
                            vm.routines.remove(atOffsets: indexSet)
                            vm.save()
                        }
                        .listStyle(.plain)
                        
                    }
                    
                    
                    
                }
            }
            .onAppear{
                let authOptions: UNAuthorizationOptions = [.alert, .sound]
                
                UNUserNotificationCenter.current().requestAuthorization(options: authOptions) { success, error in
                    
                }
            }
           .navigationTitle("타이머")
            .toolbar{
                if !vm.routines.isEmpty {
                    ToolbarItem(placement:.navigationBarLeading) {
                        
                        EditButton()
                    }
                }
                
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        selectedRoutine = RoutineModel(task: [TaskModel(emoji: .defaultEmoji, interval: "")], title: "")
                        
                        isPresented.toggle()
                        
                    } label: {
                        Image(systemName: "plus")
                            .font(.headline)
                            .foregroundColor(.blue)
                    }

                }
            
            }
            .navigationDestination(isPresented: $isPresented, destination: {
                DetailView(vm:vm,routine: $selectedRoutine)
                   
            })
            .onAppear{
                selectedRoutine = RoutineModel(task: [TaskModel(emoji: .defaultEmoji, interval: "")], title: "")
            }
        }
    }
    
    
    
}
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack{
            HomeView()
                .environmentObject(HomeViewModel())
        }
        
    }
}


//편집 모드 진입 시 재생 버튼 없얘기
