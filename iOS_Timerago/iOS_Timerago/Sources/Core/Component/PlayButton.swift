//
//  PlayButton.swift
//  iOS_Timerago
//
//  Created by yongbeomkwak on 2023/05/01.
//

import SwiftUI

struct PlayButton: View {
    var body: some View {
        
        Image(systemName: "play.fill")
            .font(.title)
            .foregroundColor(.white)
            .padding()
            .background(
            
                    Circle()
                        .fill(LinearGradient(colors: [.gradient1,.accent], startPoint: .leading, endPoint: .trailing))
                        .shadow(color:.accent.opacity(0.4),radius: 3,x: 0,y: 3)
                
                  
            )
        
        
    }
}

struct PlayButton_Previews: PreviewProvider {
    static var previews: some View {
        PlayButton()
            .previewLayout(.sizeThatFits)
    }
}
