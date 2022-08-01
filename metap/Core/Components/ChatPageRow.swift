//
//  ChatPageRow.swift
//  metap
//
//  Created by Bora Erdem on 1.08.2022.
//

import SwiftUI

struct ChatPageRow: View {
    let user: User
    var body: some View {
        VStack{
            GroupBox(){
                VStack{
                    HStack{
                        AsyncImage(url: URL(string: user.ppUrl)!) { image in
                            image.resizable()
                                .frame(width: 50, height: 50)
                                .clipShape(Circle())
                        } placeholder: {
                            ProgressView()
                                .frame(width: 50, height: 50)
                                

                        }

                        
                        
                        VStack(alignment: .leading){
                            Text(user.fullname).bold()
                            Text(user.id!).lineLimit(2)
                                .font(.footnote)
                                .foregroundColor(.secondary)
                        }
                        Spacer()
                    }
                }

            }
        }
    }
}

struct ChatPageRow_Previews: PreviewProvider {
    static var previews: some View {
        ChatPageRow(user: User(email: "amanbprabey@gmail.com", fullname: "Bora ERdem", ppUrl: "https://via.placeholder.com/600/92c952"))
    }
}
