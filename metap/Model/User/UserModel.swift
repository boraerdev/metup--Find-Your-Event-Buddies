//
//  UserModel.swift
//  metap
//
//  Created by Bora Erdem on 29.07.2022.
//

import Foundation
import FirebaseFirestoreSwift

struct User: Identifiable, Decodable {
    @DocumentID var id : String?
    let email: String
    let fullname: String
    let ppUrl: String
}
