//
//  HomeViewModel.swift
//  metap
//
//  Created by Bora Erdem on 30.07.2022.
//

import Foundation

class HomeViewModel: ObservableObject {
    
    @Published var allPost: [Post] = []
    
    init(){
        DispatchQueue.main.async {
            self.fetchAllPos()
        }
    }
    
    func fetchAllPos (){
        PostService().fetchAllPosts { posts in
            print(posts)
            self.allPost = posts
        }
    }
    
}
