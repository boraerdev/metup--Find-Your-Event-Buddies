//
//  PostLargeRowView.swift
//  metap
//
//  Created by Bora Erdem on 28.07.2022.
//

import SwiftUI

struct PostLargeRowView: View {
    var body: some View {
        VStack(alignment: .leading){
            NavigationLink {
                PostDetailView().navigationBarHidden(true)
            } label: {
                GroupBox(){
                    TabView{
                        VStack{
                            HStack{
                                VStack{
                                    titleDesc
                                    infoHstack
                                    SubCapsule(messageButton: true, title: "Bora Erdem", image: "bubble.left.and.bubble.right")
                                }
                            }
                        }
                        HStack{
                            Image("placeholderPhoto")
                                .resizable()
                                .cornerRadius(20)
                                .scaledToFill()
                                
                        }
                    }
                    
                    .frame(height:150)
                    .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                    
                    
                }
            }

            
            
        }
    }
}

struct PostLargeRowView_Previews: PreviewProvider {
    static var previews: some View {
        PostLargeRowView()
    }
}



extension PostLargeRowView {
    private var infoHstack: some View {
        VStack {
            HStack{
                HStack {
                    SubCapsule(title: "2-3", image: "person")
                    SubCapsule(title: "İki Saat", image: "clock")
                    SubCapsule(title: "Alsancak", image: "map")
                }
            }

        }
    }
    
    private var titleDesc: some View {
        VStack(alignment: .leading, spacing: 5){
            Text("Alsancak partka buluşmak lazım")
                .lineLimit(1)
                .font(.title3)
            Text("It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of")
                .lineLimit(2)
                .font(.subheadline)
                .foregroundColor(.secondary)
        }
        
    }
    
}
