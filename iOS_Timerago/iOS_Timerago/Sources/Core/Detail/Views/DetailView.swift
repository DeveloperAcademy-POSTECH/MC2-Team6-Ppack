//
//  DetailView.swift
//  iOS_Timerago
//
//  Created by yongbeomkwak on 2023/05/03.
//

import SwiftUI

struct DetailView: View {
    
    @Environment(\.dismiss) var dismiss
    
    @State var text:String = ""
    var route:RoutineModel? 
    
    var body: some View {
        ZStack(alignment: .topLeading){
            Color.background.ignoresSafeArea()
            
            VStack(spacing: 10){
                backButton
                    .padding(.top,20)
                    .onTapGesture {
                        dismiss()
                    }
                
                Text("Name")
                    .frame(maxWidth: .infinity,alignment: .leading)
                    .padding(.horizontal,16)
                    .font(.title)
            }
            
            
            
            
                        
            
        }
        .toolbar(.hidden)
        
    }
    

}

extension DetailView{
    private var backButton: some View {
        
        HStack{
            Image(systemName: "chevron.left")
                .font(.title2)
                .foregroundColor(.blue)
                //.bold()
            
            Text("Timers")
                .font(.title3)
                .foregroundColor(.blue)
                
            
            Spacer()
        }
        .padding(.leading,10)
        
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView()
    }
}
