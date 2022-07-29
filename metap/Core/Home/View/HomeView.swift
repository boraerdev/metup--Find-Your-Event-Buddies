//
//  HomeView.swift
//  metap
//
//  Created by Bora Erdem on 28.07.2022.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var vm: AuthService
    
    init(){
    }
    
    var body: some View {
        VStack(spacing:0) {
            headerView
            ScrollView {
                Text("Son eklenenler")
                    .font(.title3)
                    .fontWeight(.bold)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding([.bottom,.horizontal,.top])
                ForEach(0..<10, id: \.self) { i in
                    PostLargeRowView().padding([.horizontal, .bottom])
                        
                }
                Spacer()
            }
        }.navigationBarHidden(true)
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}

extension HomeView {
    
        
    private var headerView : some View {
        VStack (spacing:0){
            HStack {
                Text("metup!")
                    .font(.title2)
                    .foregroundColor(.accentColor)
                Spacer()
                Circle()
                    .frame(width: 32, height: 32)

                
                
            }.padding()
            Divider()
        }
        
    }
}



