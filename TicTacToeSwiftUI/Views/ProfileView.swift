//
//  ProfileView.swift
//  TicTacToeSwiftUI
//
//  Created by Joel Huber on 6/2/22.
//

import SwiftUI
import TicTacToeCore

struct ProfileView: View {
    @EnvironmentObject var gameVM: GameViewModel
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
            }
        }
    }
}

//struct ProfileView_Previews: PreviewProvider {
//    struct Preview: View {
//        @StateObject var gameVM = GameViewModel()
//        
//        var body: some View {
//            ProfileView()
//                .environmentObject(gameVM)
//        }
//    }
//    
//    static var previews: some View {
//        ProfileView()
//    }
//}
