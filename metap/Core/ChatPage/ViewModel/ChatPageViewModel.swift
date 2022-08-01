//
//  ChatPageViewModel.swift
//  metap
//
//  Created by Bora Erdem on 1.08.2022.
//

import Foundation
import Firebase

class ChatPageViewModel: ObservableObject{
    
    @Published var chats: [User] = []
    var db = Firestore.firestore()
    let auth = AuthService()
    @Published var curUser : User?
    @Published var list : [String] = []
    
    init(){
        self.fetchUser()
        self.fetchMessages()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            print(self.list)
        }
    }
    
    
    func fetchMessages(){
        guard let authUser = Auth.auth().currentUser else {return print("hata var QQQ")}
        db
            .collection("users")
            .document(authUser.uid)
            .collection("chats")
            .addSnapshotListener { query, error in
                guard let docs = query?.documents else {return}
                self.list = docs.compactMap({ snaapshot in
                    let gelenUser = snaapshot.documentID
                    UserService().fetchuserFromFb(uid: gelenUser) { gelen in
                        self.chats.append(gelen)
                    }
                    return gelenUser
                })
                
                }
                
                
            
        
        
    }
    
    func fetchUser(){
        guard let user = Auth.auth().currentUser else {return}
        UserService().fetchuserFromFb(uid: user.uid) { [weak self] user in
            self?.curUser = user
        }
    }
    
    
    
    
    
    
    
    
}
