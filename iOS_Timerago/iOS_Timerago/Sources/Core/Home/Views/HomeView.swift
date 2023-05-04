//
//  HomeView.swift
//  iOS_Timerago
//
//  Created by yongbeomkwak on 2023/05/01.
//

import SwiftUI

struct HomeView: View {
    
    @EnvironmentObject private var vm:HomeViewModel
    @State var moveCreate:Bool = false
    @State var moveEdit:Bool = false
    @State private var selectedRoutine:RoutineModel? = nil
    
    var body: some View {
        ZStack{
            
            Color.background.ignoresSafeArea()
            
            
            if vm.routines.isEmpty {
                
                Text("등록된 타이머가 없습니다.")
                    .font(.preB(18))
                    .foregroundColor(.init(hex: 0x545454,alpha: 0.5))
                    .padding(.bottom,UIScreen.height/4)
                    
                
            
            }
            else {
                List{
                    ForEach(vm.routines) { routine in
                        RoutineCardView(routine: routine)
                            .contentShape(Rectangle()) // 행 전체 클릭시 바로 재생되기 위해
                            .onTapGesture {
                                selectedRoutine = routine
                                moveEdit = true
                            }
                        
                    }
                    .onDelete { indexSet in
                        
                    }
                    .onMove { indexSet, row in
                        
                    }
                }
                .listStyle(.plain)
            }
            
            
            
            
        }
        .navigationTitle("Timers")
        .toolbar{
            if !vm.routines.isEmpty {
                ToolbarItem(placement:.navigationBarLeading) {
                    
                    EditButton()
                }
            }
            
            
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    
                    moveCreate.toggle()
                    
                } label: {
                    Image(systemName: "plus")
                        .font(.headline)
                        .foregroundColor(.blue)
                }

            }
        
        }
        .navigationDestination(isPresented: $moveCreate, destination: {
            DetailView(routine: RoutineModel(id: UUID().uuidString, task: [TaskModel(emoji: "", interval: 0)], title: "", totalTime: 0))
        })
        .navigationDestination(isPresented: $moveEdit, destination: {
            DetailLoadingView(routine: $selectedRoutine)
        })
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
