//
//  PreferenceManager+Extension.swift
//  iOS_Timerago
//
//  Created by yongbeomkwak on 2023/05/15.
//

import Foundation

extension PreferenceManager {
    /// 온보딩 여부
    /// - Parameter word: 최근 검색어
       func addRecentState(bool: [Bool]) {
           var currentState = PreferenceManager.firstApproach ?? []
           
           if !currentState.isEmpty{
               return
           }
           else {
               PreferenceManager.firstApproach = [false]
           }

           
           
       }
}
