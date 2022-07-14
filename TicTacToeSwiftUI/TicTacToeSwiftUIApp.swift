
import SwiftUI

@main
struct TicTacToeSwiftUIApp: App {
    @StateObject var auth = Auth()
    @ObservedObject var gameVM = GameViewModel()
    
    var body: some Scene {
        WindowGroup {
            if auth.isLoggedIn {
                ViewRouter()
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
