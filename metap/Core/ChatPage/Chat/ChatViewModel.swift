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
    
    @Published var messages: [Message] = [Message]()
    @Published var tmpMessages: [Message] = [Message]()
    private var cancellable = Set<AnyCancellable>()
    @Published var lastMessageId: String = ""
    @Published var toUser: User?
    @Published var fromUser : User?
    var db = Firestore.firestore()
    
    
    init(fromUser: User, toUser: User){
            self.toUser = toUser
            self.fromUser = fromUser
        DispatchQueue.main.async {
            self.getMessages()
        }
    }
    
    
    func getMessages(){
        guard let fromid = fromUser?.id else { return print("from user alınamadı")}
        guard let toid = toUser?.id else { return print("to user alınamadı") }
        
        let fromChatid = "\(fromid)-\(toid)"
        let toChatId = "\(toid)-\(fromid)"
        DispatchQueue.main.async {
            self.getFromFrom(fromChatid: fromChatid)

        }
        DispatchQueue.main.async {
            self.getFromTo(toChatId: toChatId)

        }
        fetch()
        
        
    }
    
    func getFromFrom(fromChatid: String){
        db
                .collection("messages")
                .document(fromChatid)
                .collection("chat")
                .addSnapshotListener { guery, error in
                    guard error == nil else {return}
                    guard let docs = guery?.documents else {return}
                    var temp: [Message] = []
                    temp = docs.compactMap({ snapshot in
                        var message =  try? snapshot.data(as: Message.self)
                        if message?.fromUid == self.fromUser?.id {
                            message?.received = false
                        }
                        return message
                    })
                    self.tmpMessages.append(contentsOf: temp)
                    temp = []
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
                var temp: [Message] = []
                temp = docs.compactMap({ snapshot in
                    var message =  try? snapshot.data(as: Message.self)
                    
                    if message?.fromUid == self.toUser?.id {
                        message?.received = true
                    }
                    
                    return message
                })
                
                self.tmpMessages.append(contentsOf: temp)
                temp = []
                
            }
    }
    
    func fetch(){
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            
            self.tmpMessages.sort { $0.timestamp < $1.timestamp}
            self.messages = self.tmpMessages
            if let id = self.messages.last?.id {
                self.lastMessageId = id
            }

        }
        
//        self.$tmpMessages
//            .sink { [weak self] gelen in
//                let new = gelen.sorted { $0.timestamp < $1.timestamp }
//                self?.messages = new
//                if let id = self?.messages.last?.id {
//                                self?.lastMessageId = id
//                            }
//            }
//            .store(in: &cancellable)

        
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
//            self.tmpMessages = []
//            self.messages = []
            
        }
    }
    
    
    
    
}
