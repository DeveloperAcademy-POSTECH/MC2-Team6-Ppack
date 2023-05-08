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
    
    func hideKeyboard() {
            guard let window = windows.first else { return }
            let tapRecognizer = UITapGestureRecognizer(target: window, action: #selector(UIView.endEditing))
            tapRecognizer.cancelsTouchesInView = false
            tapRecognizer.delegate = self
            window.addGestureRecognizer(tapRecognizer)
        }
     }
     
    extension UIApplication: UIGestureRecognizerDelegate {
        public func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
            return false
        }
}
