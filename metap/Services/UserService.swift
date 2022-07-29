//
//  UserService.swift
//  metap
//
//  Created by Bora Erdem on 29.07.2022.
//

import Foundation
import Firebase

struct UserService{
    
    func fetchuserFromFb(uid: String){
            Firestore.firestore().document(uid).getDocument { snapshot, error in
                guard error == nil else {return}
                
                guard let data = snapshot?.data() else {return}
                print("DEBUG: \(data)")
            }
    }
        
}

