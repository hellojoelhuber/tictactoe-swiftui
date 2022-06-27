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
                TabBarIcon(icon: Page.landingPage.iconName,
                           tabName: "Home",
                           view: .landingPage)
                
                TabBarIcon(icon: Page.activeGames.iconName, tabName: "Active", view: .activeGames)
                
                TabBarIcon(icon: Page.searchGames.iconName, tabName: "Search", view: .searchGames)
                    .disabled(true)
                    .opacity(0.3)
                
                TabBarIcon(icon: Page.localGames.iconName, tabName: "Local", view: .localGames)
                    .disabled(true)
                    .opacity(0.3)
                
                TabBarIcon(icon: Page.profile.iconName, tabName: "Profile", view: .profile)
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
