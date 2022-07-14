
import SwiftUI
import TicTacToeCore

struct GameDetailView: View {
    @StateObject var gameVM: GameDetailViewModel
    @EnvironmentObject var auth: Auth
    
    @State private var tappedSquare: Int? = nil
    
    var body: some View {
        switch gameVM.state {
        case .idle:
            Color.clear.onAppear(perform: {gameVM.loadGame(auth: auth)})
        case .loading:
            ProgressView()
        case .failed(_):
            VStack { Text("Error occurred.")}
//            ErrorView(error: error, retryHandler: gameVM.load)
        case .loaded:
            VStack {
                GameBoardView(boardSquares: gameVM.gameBoard,
                              columns: gameVM.game.boardColumns,
                              tappedSquare: $tappedSquare)
                    .onAppear {
                        updateBoard()
                    }
                    
                
                Spacer()
                
                SubmitMove
                    .disabled(tappedSquare == nil)
                
                Spacer()
            }
            .toolbar {
                RefreshGame
            }
        }
    }
    
    func updateBoard() {
        var delayDuration = 0.0
        for _ in gameVM.mostRecentTurn..<gameVM.actionHistory.count {
            withAnimation(.easeIn(duration: 0.5).delay(delayDuration)) {
               gameVM.incrementBoardState()
           }
        delayDuration += 1
        }
    }
    
    var SubmitMove: some View {
        Button("Submit Move") {
            DispatchQueue.main.async {
                gameVM.submitAction(action: tappedSquare!, auth: auth)
                tappedSquare = nil
//                updateBoard()
            }
        }
    }
    
    var RefreshGame: some View {
        Button(action: {
            DispatchQueue.main.async {
                gameVM.loadGame(auth: auth)
                updateBoard()
            }
        }) {
            Image(systemName: "arrow.clockwise")
        }
    }
}

// GameDetailViewModel requires authenticated networking request. Consider workarounds to preview View.

//struct GameDetailView_Previews: PreviewProvider {
//    struct Preview: View {
//        static let player1 = PlayerDTO(id: UUID.init(),
//                                       username: "alpha",
//                                       profileIcon: "hare")
//        static let player2 = PlayerDTO(id: UUID.init(),
//                                       username: "beta",
//                                       profileIcon: "hare")
//        static let game = GameDTO(id: UUID.init(),
//                                  boardRows: 3,
//                                  boardColumns: 3,
//                                  isPasswordProtected: false,
//                                  isMutualFollowsOnly: false,
//                                  playerCount: 2,
//                                  openSeats: 0,
//                                  completeTurnsCount: 0,
//                                  nextTurn: nil,
//                                  isComplete: false,
//                                  winner: nil,
//                                  createdBy: player1,
//                                  createdAt: Date.now,
//                                  updatedAt: Date.now,
//                                  players: [player1, player2])
//        static let gameVM = GameDetailViewModel(game: game)
//
//        var body: some View {
//            GameDetailView(gameVM: GameDetailView_Previews.Preview.gameVM)
//        }
//    }
//
//    static var previews: some View {
//        Preview()
//    }
//}


