//
//  MainTabView.swift
//  metap
//
//  Created by Bora Erdem on 28.07.2022.
//

import SwiftUI

struct MainTabView: View {
    @State var selectedIndex: Int = 0
    @State var goAdd: Bool = false

    var iconList: [String] = ["house","magnifyingglass", "plus.app", "bubble.left", "person"]
    var body: some View {
        VStack(spacing:0){
            VStack{
                switch selectedIndex{
                case 0:
                    HomeView()
                case 1:
                    ExplorePageView()
//                case 2:
//                    AddPageView()
                case 3:
                    ChatPageView()
                case 4:
                    PersonView()
                default:
                    HomeView()
                }
            }
            tabbar
                        
        }
        .navigationBarHidden(true)
    }
}

struct MainTabView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            MainTabView()

        }
    }
}

extension MainTabView{
    private var tabbar: some View {
        VStack {
            Divider()
            HStack(){
                ForEach(0..<iconList.capacity , id: \.self) { i in
                    Spacer()
                    
                    if i == 2 {
                        Image(systemName: iconList[i])
                            .foregroundColor(selectedIndex == i ? .accentColor : .secondary)
                            .font(.title2)
                            .padding(10)
                            .onTapGesture {
                                goAdd.toggle()
                            }
                            .sheet(isPresented: $goAdd) {
                                AddPageView()
                            }
                        
                        
                        
                    } else {
                        Image(systemName: iconList[i])
                            .foregroundColor(selectedIndex == i ? .accentColor : .secondary)
                            
                            .font( .title2)
                            
                            .padding(10)
                            .onTapGesture {
                                selectedIndex = i
                            }
                    }
                    Spacer()
                }
            }
        }.background(.thinMaterial)

    }
    
}
