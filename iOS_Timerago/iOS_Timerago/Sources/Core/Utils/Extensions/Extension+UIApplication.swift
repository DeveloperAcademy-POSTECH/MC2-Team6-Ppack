//
//  Extension+UIApplication.swift
//  iOS_Timerago
//
//  Created by yongbeomkwak on 2023/05/01.
//

import Foundation
import UIKit

extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil) // 키보드 없애기
    }
}
