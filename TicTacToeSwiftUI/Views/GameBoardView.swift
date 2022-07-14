
import SwiftUI
import TicTacToeCore

struct GameBoardView: View {
    let boardSquares: [Square]
    let columns: Int
    @Binding var tappedSquare: Int?
    
    var body: some View {
        AspectVGrid(items: boardSquares,
                    aspectRatio: 1,
                    columns: columns,
                    content: { square in
            SquareView(square: square)
                .background(RoundedRectangle(cornerRadius: 4.0)
                    .stroke(square.id == tappedSquare ? .red : .blue, lineWidth: 2))
                .onTapGesture {
                    tappedSquare = square.id
                }
        })
    }
}

struct GameBoardView_Previews: PreviewProvider {
    struct Preview: View {
        static let square0 = Square(id: 0)
        static let square1 = Square(id: 1)
        static let square2 = Square(id: 2)
        static let square3 = Square(id: 3)
        static let square4 = Square(id: 4)
        static let square5 = Square(id: 5)
        static let square6 = Square(id: 6)
        static let square7 = Square(id: 7)
        static let square8 = Square(id: 8)
        static let square9 = Square(id: 9)
        static let squares = [square0, square1, square2,
                              square3, square4, square5,
                              square6, square7, square8]
        @State var tappedSquare: Int? = nil
        
        var body: some View {
            GameBoardView(boardSquares: GameBoardView_Previews.Preview.squares,
                          columns: 3,
                          tappedSquare: $tappedSquare)
        }
    }
    
    static var previews: some View {
        Preview()
    }
}

