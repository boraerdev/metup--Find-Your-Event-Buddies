//
//  UserService.swift
//  metap
//
//  Created by Bora Erdem on 29.07.2022.
//

import Foundation
import Firebase

struct UserService{
    
    func fetchuserFromFb(uid: String, completion: @escaping (User)->Void){
            Firestore.firestore().collection("users").document(uid).getDocument { snapshot, error in
                guard error == nil else {return}
                guard let snapshot = snapshot else {return}
                guard let user = try? snapshot.data(as: User.self) else {return}
                completion(user)
            }
    }
        
}

