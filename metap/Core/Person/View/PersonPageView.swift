//
//  PersonView.swift
//  metap
//
//  Created by Bora Erdem on 28.07.2022.
//

import SwiftUI
import Firebase
struct PersonView: View {
    @EnvironmentObject var vm: AuthService
    @ObservedObject var personVm : PersonViewModel
    @Environment (\.presentationMode) var presentationMode
    var user: User
    
    init(user: User){
        self.user = user
        personVm = PersonViewModel(user: self.user)
    }
    
    var body: some View {
        VStack{
            nav
            .padding()
            header
            myposts
        }
    }
}

//struct PersonView_Previews: PreviewProvider {
//    static var previews: some View {
//        PersonView()
//    }
//}

extension PersonView {
    
    private var myposts: some View{
        VStack {
            Text("Tüm Etkinlikler")
                .font(.title3)
            .bold()
            Divider()
            ScrollView{
                ForEach(personVm.personsPosts) { gelen in
                    PostLargeRowView(post: gelen).padding([.bottom, .horizontal])
                }
            }
        }
    }
    
    private var checkCurUser: some View {
        VStack{
            if user.id == Auth.auth().currentUser?.uid {
                logoutButton
            }
        }
        
    }
    
    private var nav: some View {
        HStack{
            Image(systemName: "chevron.backward").font(.title2).foregroundColor(.accentColor)
                .onTapGesture {
                    presentationMode.wrappedValue.dismiss()
                }
            Spacer()
            
            checkCurUser

        }
    }
    
    private var logoutButton: some View {
        Button {
            vm.logOut()
        } label: {
            Image(systemName: "power")
                .font(.title2)
        }

    }
    
    private var header: some View {

        VStack {
            HStack {
                
                
                AsyncImage(url: URL(string: user.ppUrl)) { image in
                    image
                        .resizable()
                        .scaledToFill()
                        .clipShape(Circle())
                        .frame(width: 70, height: 70)
                } placeholder: {
                            Circle()
                        .fill(.white)
                                .frame(width: 70, height: 70)
                }

                
                
                
                VStack(alignment: .leading){
                    Text(user.fullname)
                        .fontWeight(.bold)
                    Text("@" + (personVm.user.email.split(separator: "@" )[0]))
                        .foregroundColor(.secondary)
                        .font(.subheadline)

                }
                Spacer()
                Image(systemName: "quote.bubble")
                    .font(.title)
                    .foregroundColor(.accentColor)
            }.padding()

        }
    }
    
}
