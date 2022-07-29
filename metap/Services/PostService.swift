//
//  PostService.swift
//  metap
//
//  Created by Bora Erdem on 30.07.2022.
//

import Foundation
import Firebase




struct PostService {
    
    func fetchAllPosts(completion: @escaping ([Post])->Void){
        
        Firestore.firestore().collection("posts").getDocuments { querySnapshots, error in
            var allPost: [Post] = []
            guard error == nil else {return}
            guard let snapshot = querySnapshots else {return}
            
            for document in snapshot.documents{
                guard let post = try? document.data(as: Post.self) else {return}
                allPost.append(post)
            }

            completion(allPost)
        }
        
        
    }
    
}
