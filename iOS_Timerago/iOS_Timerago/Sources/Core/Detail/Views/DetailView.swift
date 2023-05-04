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
    @State var showEmojiKeyboard:Bool = false
    
    var route:RoutineModel? 
    
    var body: some View {
        ZStack(alignment: .topLeading){
            Color.background.ignoresSafeArea()
            
            VStack(spacing: 20){
                
                header
                    .padding(.top,10)
                    
                
                TextField("Name", text: $text)
                    .frame(maxWidth: .infinity,alignment: .leading)
                    .padding(.horizontal,16)
                    .font(.largeTitle)
                    .bold()
                
                
                VStack(spacing:0){
                    
                        
                    
                        Text("00:00")
                            .font(.largeTitle)
                            .bold()
                            .padding(.vertical,25)
                            .padding(.horizontal,UIScreen.width / 2 - 70)
                            .background(
                                RoundedRectangle(cornerRadius: 12)
                                    .fill(.white)
                            )
                    
    
                    
                    List{
                        ForEach((0..<3)){ _ in
                            HStack{
                                Image(systemName: "face.smiling.inverse")
                                    .renderingMode(.template)
                                    .foregroundColor(.white)
                                    .font(.title3)
                                    .padding(7)
                                    .background(Circle().fill(Color.circle))
                                
                                
                                TextField("Add task",text: $text)
                                    .font(.title3)
                            }
                        }
                        
                        
                    }
                    .listStyle(.insetGrouped)
                       
                    
                    
                }
                .padding(.top,25)
                
            }
            
            
            
            
                        
            
        }
        .toolbar(.hidden)
        
    }
    

}

extension DetailView{
    private var header: some View {
        
        HStack{
            
            HStack(spacing:5){
                Image(systemName: "chevron.left")
                    .font(.system(size: 22))
                    .foregroundColor(.blue)
                    //.bold()
                
                Text("Timers")
                    .font(.preB(17))
                    .foregroundColor(.blue)
            }
            .onTapGesture {
                dismiss()
            }
            
                
            
            Spacer()
            
            Image(systemName: "plus")
                .foregroundColor(.blue)
                .font(.system(size: 22))
                .onTapGesture {
                    print("Add")
                }
            
        }
        .padding(.horizontal,10)
        
    }
    

    
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView()
    }
}
