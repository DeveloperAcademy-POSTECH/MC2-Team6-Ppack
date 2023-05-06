//
//  HomeView.swift
//  iOS_Timerago
//
//  Created by yongbeomkwak on 2023/05/01.
//

import SwiftUI

struct HomeView: View {
    
    @EnvironmentObject private var vm:HomeViewModel
    @State var move:Bool = false

    @State private var selectedRoutine:RoutineModel = RoutineModel(task: [], title: "0", totalTime: 0)
    
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
                    ForEach(vm.routines.indices) { index in
                        RoutineCardView(routine: $vm.routines[index])
                            .contentShape(Rectangle()) // 행 전체 클릭시 바로 재생되기 위해
                            .onTapGesture {
                                selectedRoutine = vm.routines[index]
                                move.toggle()
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
                    selectedRoutine = RoutineModel(task: [TaskModel(emoji: .defaultEmoji, interval: 0)], title: "", totalTime: 0)
                    move.toggle()
                    
                } label: {
                    Image(systemName: "plus")
                        .font(.headline)
                        .foregroundColor(.blue)
                }

            }
        
        }
        .navigationDestination(isPresented: $move, destination: {
            DetailView(routine: $selectedRoutine)
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
