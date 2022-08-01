//
//  PostDetailViewModel.swift
//  metap
//
//  Created by Bora Erdem on 30.07.2022.
//

import Foundation
import Firebase
import FirebaseStorage

class PostDetailViewModel: ObservableObject {
    
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
    
    func deletePost(post: Post){
        Firestore.firestore().collection("posts").document(post.id ?? "").delete { error in
            if let error = error {
                print(error)
            }
        }
    }
    
    
    func deleteImage(post: Post) {
        Storage.storage().reference(forURL: post.imageUrl).delete { error in
            if let error = error {
                print(error)
            }
        }
    }
    
}
