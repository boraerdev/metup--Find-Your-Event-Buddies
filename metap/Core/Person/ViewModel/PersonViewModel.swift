//
//  PersonViewModel.swift
//  metap
//
//  Created by Bora Erdem on 30.07.2022.
//

import Foundation

class PersonViewModel: ObservableObject {
    @Published var personsPosts: [Post] = []
    let vm = AuthService()
    
    init(){
        self.fetchPersonsPost()
    }
    
    func  fetchPersonsPost(){
        PostService().fetchPersonPosts(uid: (vm.userSession?.uid)!) { gelen in
            self.personsPosts = gelen
        }
    }
    
}
