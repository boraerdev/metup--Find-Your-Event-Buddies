//
//  ChatPageView.swift
//  metap
//
//  Created by Bora Erdem on 28.07.2022.
//

import SwiftUI

struct ChatPageView: View {
    var body: some View {
        VStack{
            VStack{
                Spacer()
                Text("Mesajlar listesi şimdilik destekleniyor. İletişimini etkinlik üzerindeki 'Mesaj' kısmından takip edebilirsin")
                    .foregroundColor(.secondary)
                    .font(.callout)
                    .multilineTextAlignment(.center)
                    .padding(40)
                    Spacer()
            }
        }
    }
}

struct ChatPageView_Previews: PreviewProvider {
    static var previews: some View {
        ChatPageView()
    }
}
