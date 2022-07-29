//
//  LoginPageView.swift
//  metap
//
//  Created by Bora Erdem on 28.07.2022.
//

import SwiftUI

struct LoginPageView: View {
    @State var email: String = ""
    @State var pass: String = ""
    @EnvironmentObject var vm: AuthService

    var body: some View {
        VStack{
            Spacer()
            Text("metup!").foregroundColor(.secondary)
                .font(.largeTitle)
            VStack{
                FieldView(title: "Mail", bindingVar: $email)
                FieldView(isPassword: true, title: "Şifre", bindingVar: $pass)
                
                Button {
                    vm.login(email: email, pass: pass)
                } label: {
                    Text("Giriş Yap").padding(.horizontal).foregroundColor(.accentColor).padding()            }.padding()

                }

                
                
                Spacer()
            HStack{
                Text("Hesabın var mı?").foregroundColor(.secondary)
                NavigationLink {
                    SignupPageView().navigationBarHidden(true)
                } label: {
                    Text("Kayıt Ol").foregroundColor(.accentColor)
                }

                
            }
        }
    }
}

struct LoginPageView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            LoginPageView()

        }
    }
}

extension LoginPageView {

}
