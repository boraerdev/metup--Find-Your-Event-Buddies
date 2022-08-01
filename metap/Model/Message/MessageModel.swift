//
//  Message.swift
//  metap
//
//  Created by Bora Erdem on 30.07.2022.
//

import Foundation
import Firebase

struct Message: Identifiable, Codable, Equatable {
    
    let id: String
    let message: String
    let timestamp: Date
    
    let toUid: String
    let fromUid: String
    
    var received: Bool?
    
}
