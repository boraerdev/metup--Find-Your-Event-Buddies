//
//  SubCapsule.swift
//  metap
//
//  Created by Bora Erdem on 28.07.2022.
//

import SwiftUI

struct SubCapsule: View {
    var messageButton : Bool? = false
    var title : String
    var image: String
    var body: some View {
        Capsule()
            .frame(height: 30)
            .foregroundColor(messageButton ?? false ? .accentColor : .white)
            .overlay(
                
                HStack {
                    Image(systemName: image)
                        .foregroundColor(messageButton ?? false ? .white : .accentColor)
                    Text(title)
                        .lineLimit(1)
                        .foregroundColor(messageButton ?? false ? .white : .primary)
                        .font(.caption)
                }
            )
    }
}
struct SubCapsule_Previews: PreviewProvider {
    static var previews: some View {
        SubCapsule(messageButton: false, title: "Test", image: "person")
    }
}
