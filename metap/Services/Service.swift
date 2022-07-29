//
//  Service.swift
//  metap
//
//  Created by Bora Erdem on 28.07.2022.
//

import Foundation
import UIKit
import FirebaseStorage

struct Service {
    
    func downloadPP (image: UIImage?, completion : @escaping (String) -> Void ){
        guard let image = image else { return }
        Service().uploadImage(image: image, path: "pp") { url in
                completion(url)
        }
    }
    
    func uploadImage( image: UIImage, path: String, completion: @escaping (String)->Void) {
        
        guard let data = image.jpegData(compressionQuality: 0.3) else {return}
        let uuid = UUID().uuidString
        let ref = Storage.storage().reference(withPath: "/images/\(path)/\(uuid)")
        ref.putData(data) { _ , error in
            guard error == nil else {
                print(error)
                return
            }
            ref.downloadURL { url, error in
                guard error == nil else {
                    print(error)
                    return
                }
                if let url = url {
                    let urlString = url.absoluteString
                    completion(urlString)
                }
                    
            }
            
        }
        
        
        
    }
    
    func uploadPost (etkinlikAdi: String,etkinlikAciklamasi: String,etkinlikAdresi: String,kacSaatIcinde: Int, kacKisilik: Int) {
        
    }
    
    
    
}
