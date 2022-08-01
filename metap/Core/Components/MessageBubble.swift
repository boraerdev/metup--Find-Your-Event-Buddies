//
//  MessageBubble.swift
//  metap
//
//  Created by Bora Erdem on 30.07.2022.
//

import SwiftUI

struct MessageBubble: View {
    @State var showTime : Bool = false
    var message: Message
    var body: some View {
        VStack (alignment: message.received ?? false ? .leading : .trailing){
            VStack(alignment: message.received ?? false ? .leading : .trailing ){
                    Text(message.message)
                    .foregroundColor(message.received ?? false ? .black : .white)
                        .font(.subheadline)
                        .padding()
                        .frame(alignment: message.received ?? false ? .leading : .trailing)
                        .background(
                            RoundedRectangle(cornerRadius: 10).fill(message.received ?? false ? .gray.opacity(0.2) : .accentColor)
                        )
            }
            .frame(maxWidth:250, alignment: message.received ?? false ? .leading : .trailing)
            if showTime{
                Text(message.timestamp.formatted(date: .omitted, time: .shortened))
                    .foregroundColor(.secondary)
                    .font(.caption2)
                    .padding(.horizontal)
            }
        }
        .frame(maxWidth: .infinity, alignment: message.received ?? false ? .leading : .trailing)
        .padding(.horizontal)
        .onTapGesture {
            withAnimation(.easeInOut) {
                showTime.toggle()
            }
        }
    }
}

//struct MessageBubble_Previews: PreviewProvider {
//    static var previews: some View {
//        MessageBubble(message: Message(id: "", message: "geleyim hemen öyle", timestamp: Date.now, received: false))
//    }
//}
