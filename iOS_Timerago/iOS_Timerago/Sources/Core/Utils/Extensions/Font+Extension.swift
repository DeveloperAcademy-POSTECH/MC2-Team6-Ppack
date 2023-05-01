//
//  Font+Extension.swift
//  iOS_Timerago
//
//  Created by yongbeomkwak on 2023/05/01.
//

import Foundation
import SwiftUI

extension Font {
    
    static func j500M(_ size:CGFloat = 10) -> Font { return Font.custom("Jost-Medium", size: size) }
    static func j500B(_ size:CGFloat = 10) -> Font { return Font.custom("Jost-Bold", size: size) }
    static func preM(_ size:CGFloat = 10) -> Font { return Font.custom("Pretendard-Medium", size: size) }
    static func preB(_ size:CGFloat = 10) -> Font { return Font.custom("Pretendard-Bold", size: size) }
    
}
