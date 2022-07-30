//
//  AddPageViewModel.swift
//  metap
//
//  Created by Bora Erdem on 30.07.2022.
//

import Foundation
import Firebase
import UIKit

class AddPageViewModel: ObservableObject {
    
    @Published var anyError : Bool = false
    let vm = AuthService()
    init(){
        
    }
    
    
    func uploadPost(etkinlikAdi: String,etkinlikAciklamasi: String,etkinlikAdresi: String,kacSaatIcinde: Int, kacKisilik: Int, image: UIImage){
        let userUid = vm.userSession?.uid
        Service().uploadImage(image: image, path: "post") { url in
            let data = ["tarih" : Timestamp() , "etkinlikAdi": etkinlikAdi, "etkinlikAciklamasi" : etkinlikAciklamasi, "etkinlikAdresi": etkinlikAdresi, "kacSaatIcinde": kacSaatIcinde, "kacKisilik": kacKisilik, "userUid": userUid, "imageUrl": url   ] as [String : Any]
            Firestore.firestore().collection("posts").document(UUID().uuidString)
                .setData(data) { error in
                    guard error == nil else {
                        self.anyError.toggle()
                        return
                        
                    }
                }
        }
    }
    
    
    
    
}

