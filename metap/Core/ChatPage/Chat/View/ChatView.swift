//
//  ChatView.swift
//  metap
//
//  Created by Bora Erdem on 30.07.2022.
//

import SwiftUI
import Combine

struct ChatView: View {
    
    @EnvironmentObject var auth : AuthService
    @Environment (\.presentationMode) var presentationMode
    @State var allMessages : [Message] = []
    @State var cancellable = Set<AnyCancellable>()
    @StateObject var chatVm = ChatViewModel()
    @State var message: String = ""
    let toUser: User?
    @State var fromUser : User?
    @ObservedObject var homeVm = HomeViewModel()
    
    
    init(fromUser: User? , toUser: User?){
        self.toUser = toUser
        self.fromUser = fromUser
    }
    
    var body: some View {
        ZStack{
            Color.blue.ignoresSafeArea()
            VStack(spacing:0){
                nav.padding(.vertical,5)
                userView.padding()
                VStack{
                    messageScroll
                    messageField
                }
                .frame(maxWidth: .infinity)
                .background(RoundedRectangle(cornerRadius: 10).fill(.white))
            }.edgesIgnoringSafeArea(.bottom)
        }
        .onAppear {
            DispatchQueue.main.async {
                self.chatVm.fromUser = self.homeVm.user
                self.chatVm.toUser = self.toUser
            }
            
        }
        
       
       
    }
}

//struct ChatView_Previews: PreviewProvider {
//    static var previews: some View {
//        ChatView()
//    }
//}

extension ChatView {
    
    private var userView: some View {
        HStack{
            AsyncImage(url: URL(string: toUser?.ppUrl ?? "")) { image in
                image.resizable()
                    .frame(width: 50, height: 50)
                    .clipShape(Circle())
            } placeholder: {
                Circle().fill(.blue)
                    .frame(width: 50, height: 50)
            }

            VStack(alignment: .leading, spacing:0) {
                Text(toUser?.fullname ?? "")
                    .font(.title2)
                    .bold()
                .foregroundColor(.white)
                Text("@" + (toUser?.email.split(separator: "@")[0] ?? ""))
                    .foregroundColor(.white)
                    .font(.subheadline)
            }
            Spacer()
            Image(systemName: "phone.bubble.left.fill")
                .font(.title2)
                .foregroundColor(.white)
        }
    }
    
    private var nav : some View {
        HStack{
            Image(systemName: "chevron.backward")
                .foregroundColor(.white)
                .font(.title2)
                .onTapGesture {
                presentationMode.wrappedValue.dismiss()
                }
            
            Spacer()
        }.padding(.horizontal)
    }
    
    private var messageField: some View {
        FieldView(isPassword: false, title: "Message", bindingVar: $message)
            .padding(.horizontal)
            .padding(.bottom,40)
            .onSubmit {
                guard let tuuid = chatVm.toUser?.id else {return print("tuuid alınamadı")}
                guard let authUid = chatVm.fromUser?.id else {return print("froumuid alınamadı")}
                chatVm.sendMessage(text: message, toUid: tuuid , fromUid: authUid)
                message = ""

                
        }
    }
    
    private var messageScroll : some View {
        ScrollViewReader { proxy in
            ScrollView{
                ForEach(chatVm.messages, id: \.id) { message in
                    MessageBubble(message: message)
                }
            }.padding(.vertical,8)
            .onChange(of: chatVm.lastMessageId) { id in
                proxy.scrollTo(id, anchor: .bottom)
                }
        }

    }
    
}

