//
//   RoutineCardView.swift
//  iOS_Timerago
//
//  Created by yongbeomkwak on 2023/05/01.
//

import SwiftUI

struct RoutineCardView: View {
    
    
    var routine:RoutineModel
    
    
    var body: some View {

        ZStack{
            
            VStack(alignment: .leading,spacing: 23){
                Text("\(routine.title)").font(.preB(21))
                    
                    
                
                HStack(spacing:14){
                    Text("\(routine.totalTime)m").font(.preM(14))
                    
                    Rectangle()
                        .frame(maxWidth: 1,maxHeight: 20)
                    
                
                    ForEach(routine.task.count > 4 ? (0..<4) : routine.task.indices){ index  in
                        Text(routine.task[index].emoji)
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
        RoutineCardView(routine:RoutineModel(id:UUID().uuidString ,task: [TaskModel(emoji: "✅", interval: 10),TaskModel(emoji: "💄", interval: 10),TaskModel(emoji: "✏️", interval: 10)], title:"Wake-up" , totalTime: 30))
            .previewLayout(.sizeThatFits)
    }
}
