//
//  PostDetailView.swift
//  metap
//
//  Created by Bora Erdem on 28.07.2022.
//

import SwiftUI
import Firebase

struct PostDetailView: View {
    @Environment (\.presentationMode) var presentationMode
    var post: Post
    @EnvironmentObject var envoirement: AuthService
    @ObservedObject var vm : PostDetailViewModel
    @EnvironmentObject var homeVm : HomeViewModel
    @State var goProfile: Bool = false
    let userservice = UserService()
    @State var curUser : User?
    
    init(post: Post){
        self.post = post
        vm = PostDetailViewModel(post: post)
        var temp : User?
        self.userservice.fetchuserFromFb(uid: Auth.auth().currentUser?.uid ?? "") { gelen in
            temp = gelen
        }
        self.curUser = temp
        
    }
    
    
    var body: some View {
        ZStack(alignment: .bottom) {
            VStack{
                header.padding()
                ScrollView{
                    VStack{
                        userInfo
                    }.padding(.horizontal)
                    imageView
                    adressView
                    detailView
                    Spacer()
                    
                }
            }
            messageButton

        }
       
       
        
        .sheet(isPresented: $goProfile) {
            PersonView(user: vm.user ?? User(email: "", fullname: "", ppUrl: ""))
        }
    }
}

//struct PostDetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        PostDetailView()
//    }
//}

extension PostDetailView {
    
    private var messageButton: some View {
        VStack{
            if vm.user != envoirement.userModel {
                NavigationLink {
                    ChatView(fromUser: envoirement.userModel, toUser: vm.user).navigationBarHidden(true)
                } label: {
                    shareButton
                        
                }
            }
        }
    }
    
    private var trashImagine: some View {
        VStack{
            if (post.userUid == envoirement.userSession?.uid) {
                Image(systemName: "trash").font(.title2).foregroundColor(.red)
                    .onTapGesture {
                        vm.deleteImage(post: post)
                        vm.deletePost(post: post)
                        presentationMode.wrappedValue.dismiss()
                    }
            }
        }
    }
    
    private var header: some View {
        HStack{
            Image(systemName: "chevron.backward").font(.title2).foregroundColor(.accentColor)
                .padding(.trailing)
                .onTapGesture {
                    presentationMode.wrappedValue.dismiss()
                }
            Text(post.etkinlikAdi).lineLimit(1)
                .font(.title3)
            Spacer()
            trashImagine
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
                    .frame(width: 300, height: 200, alignment: .center)
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

            }.frame(maxWidth: .infinity, minHeight: 200,alignment: .topLeading)
        }.padding(.horizontal)
    }
    
    private var userInfo: some View {
        HStack{
            AsyncImage(url: URL(string: (vm.user?.ppUrl ?? ""))) { image in
                image
                    .resizable()
                    .scaledToFill()
                    .clipShape(Circle())
                    .frame(width: 32, height: 32)
            } placeholder: {
                Circle()
                    .fill(.white)
                    .frame(width: 32, height: 32)

            }
            VStack(alignment: .leading){
                Text((vm.user?.fullname ?? ""))
                    .bold()
                Text("@" + (vm.user?.email.split(separator: "@" )[0] ?? ""))
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
            Spacer()
            VStack(alignment: .trailing){
                Text(Date(timeIntervalSince1970: Double(post.tarih.seconds)).formatted(date: .long, time: .omitted))
                    .font(.footnote).foregroundColor(.secondary)
                Text(Date(timeIntervalSince1970: Double(post.tarih.seconds)).formatted(date: .omitted, time: .shortened))
                    .font(.footnote).foregroundColor(.accentColor)
                
                

//                Text(Date().formatted(date: .long, time: .omitted)).font(.footnote).foregroundColor(.secondary)
//                Text(Date().formatted(date: .omitted, time: .shortened)).font(.footnote).foregroundColor(.accentColor)
            }
        }.onTapGesture {
            goProfile.toggle()
        }

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
