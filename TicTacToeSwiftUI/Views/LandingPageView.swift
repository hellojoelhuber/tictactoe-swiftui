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
        Button {
            gameVM.currentPage = .activeGames
        } label: {
            SimpleButton(buttonLabel: "Active Games",
                         backgroundColor: DrawingConstants.activeGamesButtonColor,
                         icon: Page.activeGames.iconName)
        }
    }
    
    var SearchForGames: some View {
        Button {
            gameVM.currentPage = .searchGames
        } label: {
            SimpleButton(buttonLabel: "Search for Games",
                         backgroundColor: DrawingConstants.searchGamesButtonColor,
                         icon: Page.searchGames.iconName)
        }
    }
    
    var PlayLocalGame: some View {
        Button {
            gameVM.currentPage = .localGames
        } label: {
            SimpleButton(buttonLabel: "Play Local Game",
                         backgroundColor: DrawingConstants.localGamesButtonColor,
                         icon: Page.localGames.iconName)
        }
    }
    
    var ViewMyProfile: some View {
        Button {
            gameVM.currentPage = .profile
        } label: {
            SimpleButton(buttonLabel: "My Profile",
                         backgroundColor: DrawingConstants.profileButtonColor,
                         icon: Page.profile.iconName)
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

struct LandingPageView_Previews: PreviewProvider {
    static var previews: some View {
        LandingPageView()
    }
}
