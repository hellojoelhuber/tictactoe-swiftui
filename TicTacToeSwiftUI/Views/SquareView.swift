
import SwiftUI

struct SquareView: View {
    let square: Square
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: DrawingConstraints.cornerRadius)
                .foregroundColor(.white)
            if square.piece != nil {
                Image(systemName: square.piece!.type == .home ? "pawprint" : "pawprint.fill")
                    .resizable()
                    .padding(DrawingConstraints.padding)
            }
        }
    }
    
    private struct DrawingConstraints {
        static let cornerRadius: CGFloat = 4
        static let padding: CGFloat = 8
//        static let edgeInsets: CGFloat = 1
    }
}

struct SquareView_Previews: PreviewProvider {
    struct Preview: View {
        let square = Square(id: 0, piece: Piece(id: 0, type: .home))
        
        var body: some View {
            SquareView(square: square)
                .frame(width: 100, height: 100)
        }
    }

    static var previews: some View {
        Preview()
    }
}
