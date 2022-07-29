//
//  ExplorePageView.swift
//  metap
//
//  Created by Bora Erdem on 28.07.2022.
//

import SwiftUI

struct ExplorePageView: View {
    @ObservedObject var exploreVm = ExploreViewModel()
    var body: some View {
        VStack{
            FieldView(bindingVar: $exploreVm.searched).padding()
            ScrollView{
                ForEach(exploreVm.searchedList) { gelen in
                    PostLargeRowView(post: gelen).padding([.bottom,.horizontal])
                }
            }
        }
    }
}

struct ExplorePageView_Previews: PreviewProvider {
    static var previews: some View {
        ExplorePageView()
    }
}
