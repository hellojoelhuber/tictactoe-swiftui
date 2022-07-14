
import SwiftUI
import TrapezoidShapes

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
                         icon: Page.activeGames.iconName,
                         leftTrapezoid: false)
        }
    }
    
    var SearchForGames: some View {
        Button {
            gameVM.currentPage = .searchGames
        } label: {
            SimpleButton(buttonLabel: "Search for Games",
                         backgroundColor: DrawingConstants.searchGamesButtonColor,
                         icon: Page.searchGames.iconName,
                         leftTrapezoid: true)
        }
    }
    
    var PlayLocalGame: some View {
        Button {
            gameVM.currentPage = .localGames
        } label: {
            SimpleButton(buttonLabel: "Play Local Game",
                         backgroundColor: DrawingConstants.localGamesButtonColor,
                         icon: Page.localGames.iconName,
                         leftTrapezoid: true)
        }
    }
    
    var ViewMyProfile: some View {
        Button {
            gameVM.currentPage = .profile
        } label: {
            SimpleButton(buttonLabel: "My Profile",
                         backgroundColor: DrawingConstants.profileButtonColor,
                         icon: Page.profile.iconName,
                         leftTrapezoid: false)
        }
    }
    
    struct SimpleButton: View {
        let buttonLabel: String
        let backgroundColor: Color
        let icon: String
        let leftTrapezoid: Bool
        
        var body: some View {
            ZStack {
                RoundedTrapezoid(cornerRadius: DrawingConstants.buttonCornerRadius,
                                 edgeRatio: DrawingConstants.buttonEdgeRatio,
                                 flexibleEdge: leftTrapezoid ? .left : .right)
                    .fill(backgroundColor)
                    .brightness(DrawingConstants.buttonBrightness)
                    .shadow(radius: DrawingConstants.shadowRadius,
                            x: DrawingConstants.shadowOffsetX,
                            y: DrawingConstants.shadowOffsetY)
                RoundedTrapezoid(cornerRadius: DrawingConstants.buttonCornerRadius,
                                 edgeRatio: DrawingConstants.buttonEdgeRatio,
                                 flexibleEdge: leftTrapezoid ? .left : .right)
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
        static let buttonCornerRadius: Double = 10
        static let buttonBorderWidth: Double = 2
        static let buttonAspectRatio = 1.5
        static let buttonPadding: Double = 5
        static let buttonEdgeRatio: Double = 0.8
        
        static let buttonContentsPadding: Double = 10
        static let buttonFontColor = Color.black
        static let buttonBrightness: Double = 0.35
        
        static let shadowRadius: Double = 10
        static let shadowOffsetX: Double = 10
        static let shadowOffsetY: Double = 10
        
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
