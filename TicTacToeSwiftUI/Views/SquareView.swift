//
//  SquareView.swift
//  TicTacToeSwiftUI
//
//  Created by Joel Huber on 6/3/22.
//

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
