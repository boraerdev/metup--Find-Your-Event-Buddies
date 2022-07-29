//
//  PostModel.swift
//  metap
//
//  Created by Bora Erdem on 30.07.2022.
//

import Foundation
import FirebaseFirestoreSwift

struct Post: Identifiable, Decodable {
    @DocumentID var id: String?
    let etkinlikAdi: String
    let etkinlikAciklamasi: String
    let etkinlikAdresi: String
    let kacSaatIcinde: Int
    let kacKisilik: Int
    let imageUrl: String
    let userUid: String
}
