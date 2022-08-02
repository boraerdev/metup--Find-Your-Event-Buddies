//
//  ChatPageView.swift
//  metap
//
//  Created by Bora Erdem on 28.07.2022.
//

import SwiftUI
import Combine

struct ChatPageView: View {
    @StateObject var vm = ChatPageViewModel()
    @State var cancellable = Set<AnyCancellable>()
    init(){
      
    }
    
    var body: some View {
        VStack{
            HStack{
                Image(systemName: "info")
                Text("Kullacıların eşsiz ID'lerini isimlerinin altında görebilirsin. Kimseyle özel bilgilerini paylaşmaman gerektiğini unutma!")

            }
            .foregroundColor(.secondary).font(.footnote).padding()
            ScrollView {
                ForEach(vm.chats, id: \.id) { gelen in
                    NavigationLink {
                        ChatView(fromUser: vm.curUser, toUser: gelen).navigationBarHidden(true)
                    } label: {
                        ChatPageRow(user: gelen).padding(.horizontal).padding(.bottom,8)
                    }

                        
                }
            }
        }
        
    }
}

struct ChatPageView_Previews: PreviewProvider {
    static var previews: some View {
        ChatPageView()
    }
}
