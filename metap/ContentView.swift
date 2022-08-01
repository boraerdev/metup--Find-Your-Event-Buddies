//
//  ContentView.swift
//  metap
//
//  Created by Bora Erdem on 28.07.2022.
//

import SwiftUI
import Firebase

struct ContentView: View {
    @EnvironmentObject var vm: AuthService
    var body: some View {
        if  Auth.auth().currentUser != nil {
            MainTabView()
        } else {
            LoginPageView()
        }
            
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
