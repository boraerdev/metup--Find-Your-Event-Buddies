//
//  ExplorePageView.swift
//  metap
//
//  Created by Bora Erdem on 28.07.2022.
//

import SwiftUI

struct ExplorePageView: View {
    @State var aranan: String = ""
    var body: some View {
        VStack{
            FieldView(bindingVar: $aranan).padding()
            ScrollView{
                
            }
        }
    }
}

struct ExplorePageView_Previews: PreviewProvider {
    static var previews: some View {
        ExplorePageView()
    }
}
