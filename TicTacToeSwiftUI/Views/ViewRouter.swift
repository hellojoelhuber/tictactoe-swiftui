//
//  ViewRouter.swift
//  TicTacToeSwiftUI
//
//  Created by Joel Huber on 6/27/22.
//

import SwiftUI

struct ViewRouter: View {
    @EnvironmentObject var gameVM: GameViewModel
    
    var body: some View {
        VStack {
            switch gameVM.currentPage {
            case .landingPage:
                LandingPageView()
            case .activeGames:
                GameListView()
            case .profile:
                ProfileView()
            default:
                LandingPageView()
            }
            
            Spacer()
            
            HStack(spacing: 30) {
                TabBarIcon(icon: ButtonIcons.landingPage, tabName: "Home", view: .landingPage)
                
                TabBarIcon(icon: ButtonIcons.active, tabName: "Active", view: .activeGames)
                
                TabBarIcon(icon: ButtonIcons.search, tabName: "Search", view: .searchGames)
                    .disabled(true)
                    .opacity(0.3)
                
                TabBarIcon(icon: ButtonIcons.local, tabName: "Local", view: .localGames)
                    .disabled(true)
                    .opacity(0.3)
                
                TabBarIcon(icon: ButtonIcons.profile, tabName: "Profile", view: .profile)
            }
            .opacity(gameVM.currentPage == .landingPage ? 0 : 1)
            .padding()
            .frame(height: 100)
            .background(Color("TabBarBackground").shadow(radius: 2))
        }
    }
}

struct ViewRouter_Previews: PreviewProvider {
    struct Preview: View {
        @StateObject var gameVM = GameViewModel()
        
        var body: some View {
            ViewRouter()
                .environmentObject(gameVM)
        }
    }
    static var previews: some View {
        Preview()
    }
}
