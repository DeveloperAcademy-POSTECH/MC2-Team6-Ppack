//
//  SwiftUIView.swift
//  iOS_Timerago
//
//  Created by yongbeomkwak on 2023/05/03.
//

import SwiftUI

struct KeyboardView: View{
    
    @State var txt:String = ""
    @State var show = false
    @State var isSelectedEmoji:Bool = false
    
    var body: some View {
        
        ZStack(alignment: .bottom) {
            
            Button {
                
                    show.toggle()
                
            } label: {
                if isSelectedEmoji {
                    Text(txt)
                        .font(.title)
                }
                else {
                    Image(systemName: "face.smiling.inverse")
                        .renderingMode(.template)
                        .foregroundColor(.blue)
                        .font(.title)
                }
            }
            .padding()
                
            
            EmojiView(show: $show, txt: $txt,isSelectedEmoji: $isSelectedEmoji)
                .offset(y:self.show ? safeArea.bottom : UIScreen.height)
        }
        .background(Color.black.edgesIgnoringSafeArea(.all))
        .animation(.default, value: show)
        
        
    }
    
}


struct EmojiView: View {
    
    @Binding var show: Bool
    @Binding var txt:String
    @Binding var isSelectedEmoji:Bool
    
    var body: some View {
        
        ZStack(alignment: .topLeading){
            ScrollView(.horizontal,showsIndicators: false){
                
                HStack(spacing:15){
                    
                    ForEach(self.getImojiList(),id: \.self){ i in
                        
                        VStack(spacing:20){
                            ForEach(i,id:\.self) { j in
                             
                                Button {
                                    self.txt = j
                                    self.show.toggle()
                                    self.isSelectedEmoji = true
                                } label: {
                                    Text(j).font(.system(size: 30))
                                }

                                
                            }
                        }
                    
                        
                    }
                    
                }
                .padding(.top)
                .padding(.horizontal)
                
            }.frame(width: UIScreen.width,height: UIScreen.height/3)
                .padding(.bottom,safeArea.bottom)
                .background(.thinMaterial)
                .cornerRadius(25)
        }
        
    }
    
    func getImojiList() -> [[String]] {
        
        
        return [["🍚", "🍫", "🥛"],["🚿", "🧻", "🧖"],["💄", "🧢","🕶️"],["👕","👔", "👠"],["📚", "💻", "📝"],["🪴", "🐶", "🐱"],["🎶","🚬", "🕹️"],["💊","💪", "🧘‍♀️"],["🚌","📞","⛅️"]]
    }
}

struct KeyboardView_Previews: PreviewProvider {
    static var previews: some View {
        KeyboardView()
    }
}

struct EmojiView_Previews: PreviewProvider {
    static var previews: some View {
        EmojiView(show: .constant(false), txt: .constant(""),isSelectedEmoji: .constant(false))
    }
}
