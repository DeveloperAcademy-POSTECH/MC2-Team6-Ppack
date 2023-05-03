//
//   RoutineCardView.swift
//  iOS_Timerago
//
//  Created by yongbeomkwak on 2023/05/01.
//

import SwiftUI

struct RoutineCardView: View {
    var body: some View {

        ZStack{
            
            VStack(alignment: .leading,spacing: 23){
                Text("Wake-up").font(.preB(21))
                    
                    
                
                HStack(spacing:14){
                    Text("60m").font(.preM(14))
                    
                    Rectangle()
                        .frame(maxWidth: 1,maxHeight: 20)
                    
                    ForEach((0..<4)){ _ in
                        Text("💄")
                            .font(.system(size: 14))
                    }
                    
                }
                
                
            }
            .frame(maxWidth: .infinity,alignment: .leading)
            .padding(.leading,23)
            .padding(.top,20)
            .padding(.bottom,25)
            PlayButton()
                .frame(maxWidth: .infinity,alignment: .trailing).padding()
        }
        
     
        
    }
}

struct RoutineCardView_Previews: PreviewProvider {
    static var previews: some View {
        RoutineCardView()
            .previewLayout(.sizeThatFits)
    }
}
