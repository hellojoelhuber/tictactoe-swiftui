//
//  GameDetailView.swift
//  TicTacToeSwiftUI
//
//  Created by Joel Huber on 5/31/22.
//

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
            GameBoardView
//            ProgressView()
        case .failed(_):
            VStack { Text("Error occurred.")}
//            ErrorView(error: error, retryHandler: gameVM.load)
        case .loaded:
            VStack {
                GameBoardView
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
    
    var GameBoardView: some View {
        AspectVGrid(items: gameVM.gameBoard, aspectRatio: 1, columns: gameVM.game.boardColumns, content: { square in
            SquareView(square: square)
                .background(RoundedRectangle(cornerRadius: 4.0)
                    .stroke(square.id == tappedSquare ? .red : .blue, lineWidth: 2))
                .onTapGesture {
                    tappedSquare = square.id
                }
        })
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
