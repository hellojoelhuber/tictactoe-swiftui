//
//  ProfileView.swift
//  TicTacToeSwiftUI
//
//  Created by Joel Huber on 6/2/22.
//

import SwiftUI
import TicTacToeCore

struct ProfileView: View {
//    @State var username = ""
//    @State var password = ""
//    @State private var showingLoginErrorAlert = false
//    @EnvironmentObject var auth: Auth
    @EnvironmentObject var gameVM: GameViewModel
//    let player = UserDefaults.value(forKey: "loggedInPlayer") as! Player
    private var player: PlayerProfileDTO?
    init() {
        player = nil
        let defaults = UserDefaults.standard
        if let savedUserData = defaults.object(forKey: "loggedInPlayer") as? Data {
            let decoder = JSONDecoder()
            if let savedUser = try? decoder.decode(PlayerProfileDTO.self, from: savedUserData) {
                self.player = savedUser
            }
        }
    }
    
    var body: some View {
        VStack {
//            Image("logo")
//                .aspectRatio(contentMode: .fit)
//                .padding(.leading, 75)
//                .padding(.trailing, 75)
            Text("\(player!.username)")
                .font(.largeTitle)
            Image(systemName: player!.profileIcon)
            Text("Played: \(player!.gamesPlayed)")
            Text("Won: \(player!.gamesWon)")
            Button("Tap") {
                if self.player != nil {
                    print(self.player!.id)
                    print(self.player!.username)
                }
//                print(gameVM.readPlayerData().id!)
//                print(gameVM.readPlayerData().firstName)
//                print(gameVM.readPlayerData().lastName)
//                print(gameVM.readPlayerData().username)
            }
//            TextField("Username", text: $username)
//                .padding()
//                .autocapitalization(.none)
//                .disableAutocorrection(true)
//                .keyboardType(.emailAddress)
//                .border(.black, width: 1)
//                .padding(.horizontal)
//            SecureField("Password", text: $password)
//                .padding()
//                .border(.black, width: 1)
//                .padding(.horizontal)
//            Button("Log In") {
//                login()
//            }
//            .frame(width: 120.0, height: 60.0)
//            .disabled(username.isEmpty || password.isEmpty)
//        }
//        .alert(isPresented: $showingLoginErrorAlert) {
//            Alert(title: Text("Error"), message: Text("Could not log in. Check your credentials and try again"))
        }
    }
    
    
//    func login() {
//        auth.login(username: username, password: password) { result in
//            switch result {
//            case .success:
//                break
//            case .failure:
//                DispatchQueue.main.async {
//                    self.showingLoginErrorAlert = true
//                }
//            }
//        }
//    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
