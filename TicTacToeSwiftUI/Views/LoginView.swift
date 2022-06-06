//
//  LoginView.swift
//  TicTacToeSwiftUI
//
//  Created by Joel Huber on 6/2/22.
//

import SwiftUI

struct LoginView: View {
    @State var username = "scarletwitch"
    @State var password = "darkhold"
    @State private var showingLoginErrorAlert = false
    @EnvironmentObject var auth: Auth
    
    var body: some View {
        VStack {
//            Image("logo")
//                .aspectRatio(contentMode: .fit)
//                .padding(.leading, 75)
//                .padding(.trailing, 75)
            Text("Log In")
                .font(.largeTitle)
            TextField("Username", text: $username)
                .padding()
                .autocapitalization(.none)
                .disableAutocorrection(true)
                .keyboardType(.emailAddress)
                .border(.black, width: 1)
                .padding(.horizontal)
            SecureField("Password", text: $password)
                .padding()
                .border(.black, width: 1)
                .padding(.horizontal)
            Button("Log In") {
                login()
            }
            .frame(width: 120.0, height: 60.0)
            .disabled(username.isEmpty || password.isEmpty)
        }
        .alert(isPresented: $showingLoginErrorAlert) {
            Alert(title: Text("Error"), message: Text("Could not log in. Check your credentials and try again"))
        }
    }
    
    func login() {
        auth.login(username: username, password: password) { result in
            switch result {
            case .success:
                break
            case .failure:
                DispatchQueue.main.async {
                    self.showingLoginErrorAlert = true
                }
            }
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
