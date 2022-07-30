//
//  PostLargeViewModel.swift
//  metap
//
//  Created by Bora Erdem on 30.07.2022.
//

import Foundation

class PostLargeViewModel: ObservableObject {
    
    @Published var name: String = ""
    @Published var user: User? = nil
    
    init(post: Post){
        self.fetchData(post: post)
    }
    
    func fetchData(post: Post){
        UserService().fetchuserFromFb(uid: post.userUid) { [weak self] user in
            self?.user = user
        }
    }
    
}
