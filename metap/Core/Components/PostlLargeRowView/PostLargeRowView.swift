//
//  PostLargeRowView.swift
//  metap
//
//  Created by Bora Erdem on 28.07.2022.
//

import SwiftUI

struct PostLargeRowView: View {
    var post: Post
    
    
    @ObservedObject var vm : PostLargeViewModel
    let imageindex: Int = -1
    let service = Service()
    @State var image: UIImage?
    
    init(post: Post){
        self.post = post
        vm = PostLargeViewModel(post: post)
    }
    
    
    var body: some View {
        VStack(alignment: .leading){
            NavigationLink {
                PostDetailView(post: post).navigationBarHidden(true)
            } label: {
                GroupBox(){
                    TabView{
                        VStack{
                            HStack{
                                VStack{
                                    titleDesc
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                    infoHstack
                                    SubCapsule(messageButton: true, title: vm.user?.fullname ?? "", image: "quote.bubble")
                                }
                            }
                        }
                        HStack{
//                            AsyncImage(url: URL(string: post.imageUrl)) { image in
//                                image
//                                    .resizable()
//                                    .cornerRadius(20)
//                                    .scaledToFill()
//
//                            } placeholder: {
//                                ProgressView()
//                            }
                            VStack{
                                if let image = image {
                                    Image(uiImage: image)
                                        .resizable()
                                        .scaledToFill()
                                }
                            }
                        }
                    }.cornerRadius(5)
                    
                    .frame(height:150)
                    .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                }
            }
        }
        .task {
            async{
                try await service.downloadAsyncImage(url: post.imageUrl) { gelen in
                    self.image = gelen
                }
            }
        }
    }
}

//struct PostLargeRowView_Previews: PreviewProvider {
//    static var previews: some View {
//        PostLargeRowView()
//    }
//}



extension PostLargeRowView {
    private var infoHstack: some View {
        VStack {
            HStack{
                HStack {
                    SubCapsule(title: String("\(post.kacKisilik) Kişi"), image: "person")
                    SubCapsule(title: String("\(post.kacSaatIcinde) Saate"), image: "clock")
                    SubCapsule(title: String(post.etkinlikAdresi), image: "map")
                }
            }

        }
    }
    
    private var titleDesc: some View {
        VStack(alignment: .leading, spacing: 5){
            Text(post.etkinlikAdi)
                .multilineTextAlignment(.leading)
                .lineLimit(1)
                .font(.title3)
            Text(post.etkinlikAciklamasi)
                .multilineTextAlignment(.leading)
                .lineLimit(2)
                .font(.subheadline)
                .foregroundColor(.secondary)
        }
        
    }
    
}
