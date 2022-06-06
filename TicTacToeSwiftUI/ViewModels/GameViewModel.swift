//
//  GameViewModel.swift
//  TicTacToeSwiftUI
//
//  Created by Joel Huber on 5/31/22.
//

import SwiftUI
import TicTacToeCore

class GameViewModel: ObservableObject {
    @Published private(set) var state = ViewState.idle
    
//    private var player: Player? = nil // TODO: This needs to be more readily accessible.
    @Published var games: [GameDTO]
    @Published var showingErrorAlert: Bool = false
    @Published var showingModalView: Bool = false
    private let loader: GameRequest
    private let poster: GameRequest
    
//    func readPlayerData() -> Player {
//        player!
//    }
    
    init() {
        self.games = []
        self.loader = GameRequest(httpMethod: "GET",
                                  resourcePath: "my")
        self.poster = GameRequest(httpMethod: "POST",
                                  resourcePath: "create")
    }
    
    func loadMyGames(auth: Auth) {
        self.state = .loading
        
        loader.getGames(auth: auth) { result in
            switch result {
            case .failure:
                DispatchQueue.main.async {
                    print("Failure")
                    self.showingErrorAlert = true
                }
            case .success(let myGames):
                DispatchQueue.main.async {
                    self.games = myGames
                    self.state = .loaded
                }
            }
        }
    }
    
    func createGame(row: Int, col: Int, password: String?, isMutualsOnly: Bool, auth: Auth) {
        let gameSettings = GameSettings(rows: row, columns: col, password: password, isMutualFollowsOnly: isMutualsOnly)
        poster.createGame(gameSettings, auth: auth) { result in
            switch result {
            case .failure:
                DispatchQueue.main.async {
                    self.showingErrorAlert = true
                }
            case .success:
                DispatchQueue.main.async {
//                    presentationMode.wrappedValue.dismiss()
                    self.showingModalView.toggle()
                }
            }
        }
    }

    func getUserData(auth: Auth) {
        PlayerRequest(httpMethod: "GET", resourcePath: "self").getPlayerInfo(auth: auth, completion: { result in
            switch result {
            case .failure:
                DispatchQueue.main.async {
                    self.showingErrorAlert = true
                }
            case .success(let player):
                DispatchQueue.main.async {
                    let defaults = UserDefaults.standard
                    let encoder = JSONEncoder()
                    if let encodedUser = try? encoder.encode(player) {
                        defaults.set(encodedUser, forKey: "loggedInPlayer")
                    }
//                    defaults.set(player, forKey: "loggedInPlayer")
//                    self.player = player
//                    presentationMode.wrappedValue.dismiss()
//                    self.showingModalView.toggle()
                }
            }
        })
    }
}


enum ViewState {
    case idle
    case loading
    case failed(Error)
    case loaded
}
