//
//  LandingPageView.swift
//  TicTacToeSwiftUI
//
//  Created by Joel Huber on 6/27/22.
//

import SwiftUI

struct LandingPageView: View {
    @EnvironmentObject var gameVM: GameViewModel
    
    var body: some View {
        VStack {
            LogoPlaceholder()
            
            HStack {
                ActiveGames
                PlayLocalGame
                    .opacity(0.3)
            }
            
            HStack {
                SearchForGames
                    .opacity(0.3)
                ViewMyProfile
            }
        }
        .padding()
    }
    
    var ActiveGames: some View {
        SimpleButton(buttonLabel: "Active Games",
                     backgroundColor: DrawingConstants.activeGamesButtonColor,
                     icon: ButtonIcons.active)
        .onTapGesture {
            gameVM.currentPage = .activeGames
        }
    }
    
    var SearchForGames: some View {
        SimpleButton(buttonLabel: "Search for Games",
                     backgroundColor: DrawingConstants.searchGamesButtonColor,
                     icon: ButtonIcons.search)
    }
    
    var PlayLocalGame: some View {
        SimpleButton(buttonLabel: "Play Local Game",
                     backgroundColor: DrawingConstants.localGamesButtonColor,
                     icon: ButtonIcons.local)
    }
    
    var ViewMyProfile: some View {
        SimpleButton(buttonLabel: "My Profile",
                     backgroundColor: DrawingConstants.profileButtonColor,
                     icon: ButtonIcons.profile)
        .onTapGesture {
            gameVM.currentPage = .profile
        }
    }
    
    struct SimpleButton: View {
        let buttonLabel: String
        let backgroundColor: Color
        let icon: String
        
        var body: some View {
            ZStack {
                RoundedRectangle(cornerRadius: DrawingConstants.buttonCornerRadius)
                    .foregroundColor(backgroundColor.opacity(0.5))
                RoundedRectangle(cornerRadius: DrawingConstants.buttonCornerRadius)
                    .stroke(style: StrokeStyle(lineWidth: DrawingConstants.buttonBorderWidth))
                VStack {
                    Image(systemName: icon)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                    Text(buttonLabel)
                }
                .padding(DrawingConstants.buttonContentsPadding)
            }
            .aspectRatio(DrawingConstants.buttonAspectRatio, contentMode: .fit)
            .foregroundColor(DrawingConstants.buttonFontColor)
            .padding(DrawingConstants.buttonPadding)
        }
    }
    
    private struct DrawingConstants {
        static let buttonCornerRadius: CGFloat = 10
        static let buttonBorderWidth: CGFloat = 2
        static let buttonAspectRatio = 1.5
        static let buttonPadding: CGFloat = 5
        
        static let buttonContentsPadding: CGFloat = 10
        static let buttonFontColor = Color.black
        
        static let activeGamesButtonColor = Color.blue
        static let searchGamesButtonColor = Color.red
        static let localGamesButtonColor = Color.orange
        static let profileButtonColor = Color.yellow
    }
}


struct ButtonIcons {
    static let landingPage = "house"
    static let active = "gamecontroller"
    static let search = "magnifyingglass.circle"
    static let local = "checkerboard.rectangle"
    static let profile = "person.circle"
}

struct LandingPageView_Previews: PreviewProvider {
    static var previews: some View {
        LandingPageView()
    }
}
