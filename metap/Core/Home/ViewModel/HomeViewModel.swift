//
//  HomeViewModel.swift
//  metap
//
//  Created by Bora Erdem on 30.07.2022.
//

import Foundation
import Firebase

class HomeViewModel: ObservableObject {
    
    let authservice = AuthService()
    @Published var allPost: [Post] = []
    @Published var user : User?
    
    init(){
        DispatchQueue.main.async {
            self.fetchAllPos()
            self.fetchUser()
        }
    }
    
    func fetchAllPos (){
        PostService().fetchAllPosts { posts in
            self.allPost = posts
        }
    }
    
    func fetchUser(){
        guard let user = Auth.auth().currentUser else {return}
            UserService().fetchuserFromFb(uid: user.uid) {  user in
                self.user = user
                

            }
    }
    
}
