//
//  HomeView.swift
//  metap
//
//  Created by Bora Erdem on 28.07.2022.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var vm: AuthService
    @StateObject var homeVm = HomeViewModel()
    @Binding var selectedIndex: Int
    
    
    var body: some View {
        VStack(spacing:0) {
            headerView
            ScrollView {
                title
                ForEach(homeVm.allPost) { gelen in
                    PostLargeRowView(post: gelen).padding(.horizontal).padding(.bottom,8)
                }
                Spacer()
            }
        }.navigationBarHidden(true)
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(selectedIndex: .constant(0))
    }
}

extension HomeView {
    
    private var title: some View {
        Text("Son eklenenler")
            .font(.title3)
            .fontWeight(.bold)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding([.horizontal,.top]).padding(.bottom,8)
    }
    
    private var headerView : some View {
        VStack (spacing:0){
            HStack {
                Text("metup!")
                    .font(.title2)
                    .foregroundColor(.accentColor)
                Spacer()

                AsyncImage(url: URL(string: vm.userModel?.ppUrl ?? "")) { image in
                    image
                        .resizable()
                        .scaledToFill()
                        .frame(width: 32, height: 32)
                        .clipShape(Circle())

                } placeholder: {
                    Circle()
                        .fill(.white)
                        .frame(width: 32, height: 32)

                }.onTapGesture {
                    selectedIndex = 4
                }
               

                
                
            }.padding()
            Divider()
        }
        
    }
}



