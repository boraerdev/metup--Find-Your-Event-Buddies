//
//  NumberPicker.swift
//  metap
//
//  Created by Bora Erdem on 28.07.2022.
//

import SwiftUI

struct pickerView: View {
    var title: String
    @Binding var bind: Int
    var body: some View{
        GroupBox(){
            HStack{
                Text(title)
                Spacer()
                GroupBox(){
                    Picker(selection: $bind) {
                        ForEach(1..<25) { i in
                            Text(String(i)).tag(i)
                        }
                    } label: {
                        Text("Picker")
                    }.pickerStyle(.automatic)
                        .frame(maxWidth:10, maxHeight: 10)
                }

            }
        }

    }
}

//struct NumberPicker_Previews: PreviewProvider {
//    static var previews: some View {
//        NumberPicker()
//    }
//}
//
