//
//  Color+Extension.swift
//  iOS_Timerago
//
//  Created by yongbeomkwak on 2023/05/01.
//

import Foundation
import SwiftUI

extension Color {
    
    init(hex: UInt, alpha: Double = 1){
        self.init(.sRGB, red: Double((hex >> 16) & 0xff) / 255, green: Double((hex >> 08) & 0xff) / 255, blue: Double((hex >> 00) & 0xff) / 255, opacity: alpha
        )
    }
    
    static let accent = Color("Accent")
    static let background = Color("Background")
    static let gradient1 = Color("Gradient1")
    static let negative = Color("Negative")
    static let text = Color("Text")
    
}


