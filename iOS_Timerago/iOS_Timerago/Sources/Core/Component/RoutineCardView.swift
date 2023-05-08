//
//   RoutineCardView.swift
//  iOS_Timerago
//
//  Created by yongbeomkwak on 2023/05/01.
//

import SwiftUI

struct RoutineCardView: View {
    
    
    @Binding var routine:RoutineModel
    
    
    var body: some View {

        ZStack{
            
            VStack(alignment: .leading,spacing: 23){
                Text("\(routine.title)").font(.preB(21))
                    
                    
                
                HStack(spacing:14){
                    Text("\(routine.task.map{$0.interval}.reduce(0, {$0 + $1}))m").font(.preM(14))
                    
                    Rectangle()
                        .frame(maxWidth: 1,maxHeight: 20)
                    
                
                    ForEach(routine.task.count > 4 ? (0..<4) : routine.task.indices){ index  in
                        Text(routine.task[index].emoji)
                            .font(.system(size: 14))
                    }
                    
                }
                
                
            }
            .frame(maxWidth: .infinity,alignment: .leading)
            .padding(.leading,5)
            .padding(.top,20)
            .padding(.bottom,25)
            PlayButton()
                .frame(maxWidth: .infinity,alignment: .trailing).padding()
        }
        
     
        
    }
}

