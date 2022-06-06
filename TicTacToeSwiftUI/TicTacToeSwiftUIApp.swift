//
//  TicTacToeSwiftUIApp.swift
//  TicTacToeSwiftUI
//
//  Created by Joel Huber on 5/31/22.
//

import SwiftUI

@main
struct TicTacToeSwiftUIApp: App {
    @StateObject var auth = Auth()
    @ObservedObject var gameVM = GameViewModel()
    
    var body: some Scene {
        WindowGroup {
            if auth.isLoggedIn {
                TabView {
                    GameListView()
                        .tabItem { Label("Games", systemImage: "die.face.3") }
                    ProfileView()
                        .tabItem { Label("Profile", systemImage: "person") }
                }
                .environmentObject(auth)
                .environmentObject(gameVM)
            } else {
                LoginView()
                    .environmentObject(auth)
                    .onDisappear(perform: { gameVM.getUserData(auth: auth) })
            }
        }
        
        WindowGroup {
            
        }
    }
}
