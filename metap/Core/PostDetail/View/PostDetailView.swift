//
//  PostDetailView.swift
//  metap
//
//  Created by Bora Erdem on 28.07.2022.
//

import SwiftUI

struct PostDetailView: View {
    @Environment (\.presentationMode) var presentationMode
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

struct PostDetailView_Previews: PreviewProvider {
    static var previews: some View {
        PostDetailView()
    }
}

extension PostDetailView {
    
    private var header: some View {
        HStack{
            Image(systemName: "chevron.backward").font(.title).foregroundColor(.accentColor)
                .onTapGesture {
                    presentationMode.wrappedValue.dismiss()
                }
            Text("Alsancakta buluşcak var mı").lineLimit(1)
                .font(.title3)
            Spacer()
        }

    }
    
    private var imageView: some View {
        VStack{
            Image("placeholderPhoto")
                .resizable()
                .cornerRadius(10)
                .scaledToFit()
                .padding()
                
            HStack{
                SubCapsule(messageButton: true, title: "2-3", image: "person")
                SubCapsule(title: "2 Saat İçinde", image: "clock")
            }.padding(.horizontal)
        }

    }
    
    private var adressView : some View {
        HStack(alignment: .top){
            Image(systemName: "map").foregroundColor(.accentColor)
            Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit. In sit amet molestie eros. Mauris cursus facilisis luctus. Morbi quis hendrerit lectus, sit amet tempus augue. Nulla volutpat iaculis libero.").foregroundColor(.secondary)
        }.padding()
    }
    
    private var detailView: some View {
        GroupBox(){
            VStack(alignment: .leading){
                Text("Etkinlik Detayları").font(.title3).bold().padding(.vertical,6)
                Text("Aenean sed fermentum augue. Vestibulum consectetur, felis eu tempus lobortis, sem quam pharetra magna, nec mattis ante odio vel turpis. Suspendisse magna ante, tincidunt eget commodo quis, scelerisque sed diam. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Aenean ultrices porta ullamcorper. In dictum leo sit amet viverra commodo. Fusce facilisis nisl in nulla aliquet, at venenatis felis vehicula.")

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
