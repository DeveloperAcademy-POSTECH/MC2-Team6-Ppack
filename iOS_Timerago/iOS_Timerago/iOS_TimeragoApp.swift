//
//  iOS_TimeragoApp.swift
//  iOS_Timerago
//
//  Created by yongbeomkwak on 2023/04/28.
//

import SwiftUI

@main
struct iOS_TimeragoApp: App {
    
    @StateObject private var vm:HomeViewModel = HomeViewModel()
    

    var body: some Scene {
        WindowGroup {
            NavigationStack{
                KeyboardView()
//                HomeView()
//                    .environmentObject(vm)
   
            }  
        }
    }
}

//                        .onAppear{
//                            for family in UIFont.familyNames {
//                                        print(family)
//
//                                        for names in UIFont.fontNames(forFamilyName: family) {
//                                            print("== \(names)")
//                                        }
//                            }
//                        }
