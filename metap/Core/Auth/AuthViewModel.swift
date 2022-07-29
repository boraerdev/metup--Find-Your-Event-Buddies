//
//  AuthViewModel.swift
//  metap
//
//  Created by Bora Erdem on 28.07.2022.
//

import Foundation
import Firebase
import FirebaseFirestore
import UIKit

class AuthService: ObservableObject {
    
    @Published var userSession : FirebaseAuth.User?
    @Published var errorMesage: String?
    @Published var anError : Bool = false
    @Published var userModel: User?
    
    init(){
            self.userSession = Auth.auth().currentUser
            self.fetchUser()
        
    }
    
    func logOut(){
        self.userSession = nil
        try? Auth.auth().signOut()
        
    }
    
    
    func login(email: String, pass: String ){
        Auth.auth().signIn(withEmail: email, password: pass) { result, error in
            guard error == nil else {return}
            guard let user = result?.user else {return}
            self.userSession = user
        }
    }
    
    func fetchUser(){
        guard let user = self.userSession else {return}
        UserService().fetchuserFromFb(uid: user.uid) { [weak self] user in
            self?.userModel = user
        }
    }
    
    
    func register(fullName: String, email: String, pass: String, image: UIImage?) {
        Auth.auth().createUser(withEmail: email, password: pass) { result, error in
            guard  error == nil else {
                self.errorMesage = error!.localizedDescription
                self.anError.toggle()
                return
            }
            
            self.userSession = result?.user
            guard let image = image else {return}
            Service().downloadPP(image: image) { url in
                var ppUrl = url
                let data = ["fullname": fullName, "email": email, "ppUrl": ppUrl] as [String: Any]
                Firestore.firestore().collection("users").document((self.userSession?.uid)!).setData(data) { error in
                    if let error = error {
                                print(error)
                    }
                }
            }
            guard let user = result?.user else {return}
            self.userSession = user


        }
    }
    
    
    
    
    
    
    
    
    
    
}
