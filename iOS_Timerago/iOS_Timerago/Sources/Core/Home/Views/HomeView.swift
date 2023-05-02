//
//  HomeView.swift
//  iOS_Timerago
//
//  Created by yongbeomkwak on 2023/05/01.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        ZStack{
            
            Color.background.ignoresSafeArea()
            
            List{
                ForEach((0..<5)){ _ in
                    RoutineCardView()
                }
            }
            .listStyle(.plain)
            
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
