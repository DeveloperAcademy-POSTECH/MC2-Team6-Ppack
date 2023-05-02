//
//   RoutineCardView.swift
//  iOS_Timerago
//
//  Created by yongbeomkwak on 2023/05/01.
//

import SwiftUI

struct RoutineCardView: View {
    var body: some View {
        
        VStack(alignment: .leading){
            
            HStack{
                Text("Wake-up")
                
            }
            .padding(.vertical,20)
            
            HStack{
                Text("25 m")
                
                Rectangle()
                    .frame(width: 1,height: 30)
                
                
                ForEach(0..<10) { i in
                    Text("\(i)")
                    
                }
            }
            
            
                
                
            
            
            
            
            
        }
        .padding(.horizontal,20)
        .background{
            RoundedRectangle(cornerRadius: 24)
                .fill(.red)
        }
     
        
    }
}

struct RoutineCardView_Previews: PreviewProvider {
    static var previews: some View {
        RoutineCardView()
            .previewLayout(.sizeThatFits)
    }
}
