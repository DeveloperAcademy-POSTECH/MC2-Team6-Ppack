//
//  HomeView.swift
//  iOS_Timerago
//
//  Created by yongbeomkwak on 2023/05/01.
//

import SwiftUI

struct HomeView: View {
    
    @EnvironmentObject private var vm:HomeViewModel
    
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
                    
                    
                } label: {
                    Image(systemName: "plus")
                        .font(.headline)
                        .foregroundColor(.blue)
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
