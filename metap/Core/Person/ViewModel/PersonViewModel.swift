//
//  PersonViewModel.swift
//  metap
//
//  Created by Bora Erdem on 30.07.2022.
//

import Foundation
import Firebase

class PersonViewModel: ObservableObject {
    @Published var personsPosts: [Post] = []
    @Published var vurUser: Bool = false
    @Published var user : User
    let vm = AuthService()
    
    init(user: User){
        self.user = user
        self.fetchPersonsPost()
    }
    
    func checkCurUser(completion: (Bool)-> Void){
        guard let user = vm.userModel else { return }
        if user.id == Auth.auth().currentUser?.uid {
            completion(true)
        } else {
            completion(false)
        }
    }
    
    func  fetchPersonsPost(){
        guard let userid = user.id else {return}
        PostService().fetchPersonPosts(uid: userid) { gelen in
            self.personsPosts = gelen
        }
    }
    
}
