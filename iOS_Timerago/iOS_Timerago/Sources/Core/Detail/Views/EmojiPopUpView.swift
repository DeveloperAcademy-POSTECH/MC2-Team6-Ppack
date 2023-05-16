//
//  EmojiPopUpView.swift
//  iOS_Timerago
//
//  Created by yongbeomkwak on 2023/05/16.
//

import SwiftUI

struct EmojiPopUpView: View {
    
    @Environment(\.dismiss) var dismiss
    
    @Binding var str:String
    let emojis:[[String]] =  [
                            ["🥰", "😄", "😎", "😡", "😭"],
                            ["🍚", "🍳", "🥛","🍎","🍞"],
                            ["🚿", "🧻", "🧖","🪒","🪥"],
                            ["💄", "🧢", "🕶️","🧴","💈"],
                            ["🫧","🧺","🧼","🧽","🧹"],
                            ["👕", "👔", "👠","🧣","👗"],
                            ["📚", "💻", "📝","🧐","📒"],
                            ["🪴", "🐶", "🐱","🐹","🦜"],
                            ["🎶", "🚬", "🕹️","🎧","📱"],
                            ["💊", "💪", "🧘‍♀️","⚽️","🏋️"],
                            ["🚌", "📞", "⛅️","🚖","🚈"]
    ]
    
    
    let columns:[GridItem] = [GridItem(.flexible(),spacing: 0),GridItem(.flexible()),GridItem(.flexible()),GridItem(.flexible()),GridItem(.flexible())]
    
    var body: some View {
        
        ScrollView(.vertical,showsIndicators: false){
            VStack(spacing:15){
                
                ForEach(emojis.indices){ i in
                    
                    HStack(spacing: 25) {
                        ForEach(emojis[i].indices) { j in
                            Button {
                                str = emojis[i][j]
                                dismiss()
                                
                            } label: {
                                Text(emojis[i][j])
                                    .font(.system(size: 45))
                            }

                        }
                    }
                    
                    
                }
                
            }
        }
        .frame(maxWidth:.infinity)
        .background(.white)
        
    }
}

struct EmojiPopUpView_Previews: PreviewProvider {
    static var previews: some View {
        EmojiPopUpView(str: .constant(""))
    }
}
    
