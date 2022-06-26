//
//  GameListView.swift
//  TicTacToeSwiftUI
//
//  Created by Joel Huber on 5/31/22.
//

import SwiftUI
import TicTacToeCore

struct GameListView: View {
    @EnvironmentObject var gameVM: GameViewModel
    @EnvironmentObject var auth: Auth
    
    var body: some View {
        switch gameVM.state {
        case .idle:
            Color.clear.onAppear(perform: { gameVM.loadMyGames(auth: auth) })
        case .loading:
            ProgressView()
        case .failed(_):
            VStack { Text("Error occurred.")}
//            ErrorView(error: error, retryHandler: gameVM.load)
        case .loaded:
            GeometryReader { geometry in
                VStack {
                    Text("Games: \(gameVM.games.count)")
                        .padding()
                    NavigationView {
                        List {
                            ForEach(gameVM.games, id: \.id) { game in
                                NavigationLink(destination: GameDetailView(gameVM: GameDetailViewModel(game: game)).onDisappear(perform: {gameVM.loadMyGames(auth: auth)})) {
                                    VStack {
                                        Text("Game \(game.id.description)")
                                        Text("\(game.boardRows)x\(game.boardColumns)\t\(game.isComplete ? "Complete" : "Active")")
                                        HStack {
                                            Text("\(game.isComplete ? "Winner:" : "Next Turn:")")
                                            if (game.nextTurn != nil) {
                                                Image(systemName: game.nextTurn!.profileIcon)
                                                Text("\(game.nextTurn!.username)")
                                             } else { Text("none") }
                                        }
                                        HStack {
                                            Text(game.createdAt!, style: .date)
                                            Text(game.createdAt!, style: .time)
                                        }
                                        
                                    }
                                }
                                
                            }
                        }
                        .toolbar {
                            CreateGame
                        }
                    }
                }
            }
            .sheet(isPresented: $gameVM.showingModalView) {
                CreateGameView()
                    .environmentObject(auth)
                    .environmentObject(gameVM)
            }
        }
        
    }
    
    var CreateGame: some View {
        Button(
            action: {
                gameVM.showingModalView.toggle()
            }, label: {
                Image(systemName: "plus")
            })
    }
}

//struct ContentView_Previews: PreviewProvider {
//    struct Preview: View {
//        @StateObject var gameVM = GameViewModel()
//        @StateObject var auth = Auth()
//        let username = "admin"
//        let password = "password"
//        
//        var body: some View {
//            GameListView()
//                .onAppear {
//                    auth.login(username: username, password: password) { result in
//                        switch result {
//                        case .success:
//                            break
//                        case .failure:
//                            DispatchQueue.main.async {
//                                self.showingLoginErrorAlert = true
//                            }
//                        }
//                    }
//                }
//                .environmentObject(gameVM)
//                .environmentObject(auth)
//        }
//    }
//    
//
//    static var previews: some View {
//        Preview()
//    }
//}
