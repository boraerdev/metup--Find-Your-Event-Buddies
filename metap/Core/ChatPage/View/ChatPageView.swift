//
//  ChatPageView.swift
//  metap
//
//  Created by Bora Erdem on 28.07.2022.
//

import SwiftUI
import Combine

struct ChatPageView: View {
    @StateObject var vm = ChatViewModel()
    @State var chats: [User] = []
    @State var cancellable = Set<AnyCancellable>()
    init(){
      
    }
    
    var body: some View {
        VStack{
            ScrollView {
                ForEach(vm.chatlist, id: \.id) { gelen in
                    ChatPageRow(user: gelen)
                }
            }
        }
        .onAppear {
            
            print(vm.chatlist.count)
           
        }
    }
}

struct ChatPageView_Previews: PreviewProvider {
    static var previews: some View {
        ChatPageView()
    }
}
