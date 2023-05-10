//
//  LaunchView.swift
//  iOS_Timerago
//
//  Created by 이신영 on 2023/05/10.
//


import SwiftUI
import SDWebImageSwiftUI

struct LaunchView: View {
    @State var animationFinished: Bool = false
    var body: some View {
        
        ZStack{
            
            Color.accent
                .ignoresSafeArea()
            
            AnimatedImage(url: getLogoURL())
                .resizable()
                .scaledToFit()
                .frame(width:392)
                .offset(y:-20)
                .aspectRatio(contentMode: .fit)
        }
    }
    
    func getLogoURL()->URL{
        let bundle = Bundle.main.path(forResource: "logo", ofType: "gif")
        let url = URL(fileURLWithPath: bundle ?? "")
        
        return url
    }
}

struct LaunchScreen_Previews: PreviewProvider {
    static var previews: some View {
        LaunchView()
    }
}
