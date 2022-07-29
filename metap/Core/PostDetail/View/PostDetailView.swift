//
//  PostDetailView.swift
//  metap
//
//  Created by Bora Erdem on 28.07.2022.
//

import SwiftUI

struct PostDetailView: View {
    @Environment (\.presentationMode) var presentationMode
    var post: Post
    var body: some View {
        ZStack(alignment: .bottom) {
            VStack{
                header.padding()
                ScrollView{
                    imageView
                    adressView
                    detailView
                    Spacer()
                }
            }
            shareButton
        }
    }
}

//struct PostDetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        PostDetailView()
//    }
//}

extension PostDetailView {
    
    private var header: some View {
        HStack{
            Image(systemName: "chevron.backward").font(.title).foregroundColor(.accentColor)
                .onTapGesture {
                    presentationMode.wrappedValue.dismiss()
                }
            Text(post.etkinlikAdi).lineLimit(1)
                .font(.title3)
            Spacer()
        }

    }
    
    private var imageView: some View {
        VStack{
            
            AsyncImage(url: URL(string: post.imageUrl)) { image in
                image
                    .resizable()
                    .cornerRadius(10)
                    .scaledToFit()
                    .padding()

            } placeholder: {
                ProgressView()
            }

            
            
            
                
            HStack{
                SubCapsule(messageButton: true, title : String("\(post.kacSaatIcinde) Kişi") , image: "person")
                SubCapsule(title: String("\(post.kacKisilik) Saat İçinde"), image: "clock")
            }.padding(.horizontal)
        }

    }
    
    private var adressView : some View {
        HStack(alignment: .top){
            Image(systemName: "map").foregroundColor(.accentColor)
            Text(post.etkinlikAdresi).foregroundColor(.secondary)
        }.padding()
    }
    
    private var detailView: some View {
        GroupBox(){
            VStack(alignment: .leading){
                Text("Etkinlik Detayları").font(.title3).bold().padding(.vertical,6)
                Text(post.etkinlikAciklamasi)

            }
        }.padding(.horizontal)
    }
    
    private var shareButton : some View {
        HStack{
            Image(systemName: "bubble.left.and.bubble.right")
              
            Text("Mesaj").font(.title2)
        }
        .padding()
        .padding(.horizontal)
        .background(
            RoundedRectangle(cornerRadius: 10)
                .foregroundColor(.white)
                .shadow(color: .black.opacity(0.3), radius: 15, x: 0, y: 10)
        )
        .foregroundColor(.accentColor)
        
    }

    
    
}
