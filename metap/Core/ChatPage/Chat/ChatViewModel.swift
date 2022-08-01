//
//  ChatViewModel.swift
//  metap
//
//  Created by Bora Erdem on 31.07.2022.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift
import SwiftUI
import Combine

class ChatViewModel: ObservableObject {
    
    @Published var messages: [Message] = []
    @Published var tmpMessages: [Message] = []
    private var cancellable = Set<AnyCancellable>()
    @ObservedObject var chatpageVm = ChatPageViewModel()
    @Published var lastMessageId: String = ""
    @Published var toUser: User?
    @Published var fromUser : User?
    var db = Firestore.firestore()
    @Published var fromMessages: [Message] = []
    @Published var toMessages: [Message] = []
    
    @Published var chatlist : [User] = []
    
    
    
    init(){
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            self.getMessages()
        }
    }
    
    
    func getMessages(){
        guard let fromid = fromUser?.id else { return print("from user alınamadı")}
        guard let toid = toUser?.id else { return print("to user alınamadı") }
        
        let fromChatid = "\(fromid)-\(toid)"
        let toChatId = "\(toid)-\(fromid)"
        


            self.getFromFrom(fromChatid: fromChatid)

            self.getFromTo(toChatId: toChatId)

        

        //self.topla(toChatId: toChatId, fromChatid: fromChatid)
        
            
            
            
    }
    
    func addToRow(gelen: User?){

        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            if let user = gelen{
                if (self.chatlist.firstIndex(where: { $0.id == user.id}) == nil) {
                    self.chatlist.append(user)
                    print(self.chatlist.count)
                }
            }

        }
    }
    
    
    func getFromFrom(fromChatid: String){
        db
                .collection("messages")
                .document(fromChatid)
                .collection("chat")
                .addSnapshotListener { guery, error in
                    guard error == nil else {return}
                    guard let docs = guery?.documents else {return}
                    
                    self.fromMessages = docs.compactMap({ snapshot in
                        var message = try? snapshot.data(as: Message.self)
                        if message?.fromUid == self.fromUser?.id {
                            message?.received = false
                        }
                        return message
                    })
                    
                    
                    self.messages = self.toMessages + self.fromMessages
                    self.messages.sort { $0.timestamp < $1.timestamp}
                    if let id = self.messages.last?.id {
                    self.lastMessageId = id
                    }
                    
                    
                }
    }

    
    
    func getFromTo(toChatId: String){
        db
                .collection("messages")
                .document(toChatId)
                .collection("chat")
                .addSnapshotListener { guery, error in
                    guard error == nil else {return}
                    guard let docs = guery?.documents else {return}
                   
                    self.toMessages = docs.compactMap({ snapshot in
                        var message = try? snapshot.data(as: Message.self)
                        if message?.toUid == self.fromUser?.id {
                            message?.received = true
                        }
                        return message
                    })
                    self.messages = self.toMessages + self.fromMessages
                    self.messages.sort { $0.timestamp < $1.timestamp}
                    if let id = self.messages.last?.id {
                    self.lastMessageId = id
                    }
                }
    }
    
    
    
    func sendMessage(text: String, toUid: String, fromUid: String){
        let id = UUID().uuidString
        let data = ["id": id, "message" : text, "timestamp" : Date() , "toUid": toUid, "fromUid":fromUid  ] as [String : Any]
        let chatid = "\(fromUid)-\(toUid)"
        
        db.collection("messages")
            .document(chatid)
            .collection("chat")
            .document()
            .setData(data) { error in
        }
    }

}
