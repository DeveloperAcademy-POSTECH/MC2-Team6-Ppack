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
            
            List{
                ForEach(vm.routines) { routine in
                    RoutineCardView(routine: routine)
                }
            }
            .listStyle(.plain)
            
        }
        .navigationTitle("Timers")
        .toolbar{
            ToolbarItem(placement:.navigationBarLeading) {
                    EditButton()
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
