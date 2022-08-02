//
//  SignupPageView.swift
//  metap
//
//  Created by Bora Erdem on 28.07.2022.
//

import SwiftUI

struct SignupPageView: View {
    @State var fullName: String = ""
    @State var email: String = ""
    @State var pass: String = ""
    @EnvironmentObject var vm: AuthService
    @State private var image: UIImage? = nil
    @State private var showSheet = false


    var body: some View {
        VStack{
            Spacer()
            Text("metup!").foregroundColor(.secondary)
                .font(.largeTitle)
            VStack{
                placeholderImage
                    .onTapGesture {
                        showSheet = true
                    }
                FieldView(title: "Tam Ad", bindingVar: $fullName)
                FieldView(title: "Mail", bindingVar: $email)
                FieldView(isPassword: true, title: "Şifre", bindingVar: $pass)
                registerButton
                
                }
            Spacer()
            HStack{
                Text("Hesabın var mı?").foregroundColor(.secondary)
                NavigationLink {
                    LoginPageView().navigationBarHidden(true)
                } label: {
                    Text("Giriş Yap").foregroundColor(.accentColor)
                    }
                }
            }
        .padding(.horizontal)
        .sheet(isPresented: $showSheet) {
                    ImagePicker(sourceType: .photoLibrary, selectedImage: self.$image)
        }
    }
}


struct SignupPageView_Previews: PreviewProvider {
    static var previews: some View {
        SignupPageView()
        }
}



extension SignupPageView{
    
    //MARK: Funcs
    
    private func register() {
        guard fullName != "" && pass != "" && email != "" && image != nil else {
            vm.anError.toggle()
            return
        }
        vm.register(fullName: fullName, email: email, pass: pass, image: image)
    }
    
    //MARK: Views
    
    private var registerButton: some View {
        Button {
            register()
        } label: {
            Text("Kayıt Ol")
            .padding(.horizontal)
            .foregroundColor(.accentColor)
            .padding()}
        .padding()
        .alert(isPresented: $vm.anError) {
                Alert(title: Text("Error"), message: Text(vm.errorMesage ?? "Eksik bilgilerinizi kontrol ediniz."), dismissButton: Alert.Button.default(Text("OK")))
            }
    }
    
    private var placeholderImage: some View {
        VStack {
            if image != nil {
                Image(uiImage: image ?? UIImage())
                    .resizable()
                    .clipShape(Circle())
                    .frame(width: 150, height: 150)
                    .scaledToFit()
                    .padding()



            } else {
                Image(systemName: "person.crop.circle.fill.badge.plus")
                    .resizable()
                    .foregroundColor(.accentColor)
                    .scaledToFit()
                    .frame(width:150, height: 150)
                    .padding()
                    
                
            }
        }

    }
}
