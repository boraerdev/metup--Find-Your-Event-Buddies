//
//  FieldView.swift
//  metap
//
//  Created by Bora Erdem on 28.07.2022.
//

import SwiftUI

struct FieldView: View {
    @State var isPassword: Bool = false
    @State var title: String = "Arayın"
    @Binding var bindingVar: String
    var body: some View {
        GroupBox(){
            view
        }
    }
}

struct FieldView_Previews: PreviewProvider {
    static var previews: some View {
        FieldView(bindingVar: .constant(""))
    }
}

extension FieldView{
    private var view: some View {
        VStack{
            if isPassword {
                SecureField(title, text: $bindingVar)
            } else {
                TextField(title, text: $bindingVar)
            }
        }
    }
}
