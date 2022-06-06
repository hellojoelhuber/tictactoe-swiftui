//
//  Piece.swift
//  TicTacToeSwiftUI
//
//  Created by Joel Huber on 6/3/22.
//

import Foundation

public struct Piece: Identifiable {
    public enum PieceType {
        case home
        case visitor
//        case empty
    }
    
    public let id: Int
    public var type: PieceType
    
    init(id: Int, type: PieceType) {
        self.id = id
        self.type = type
    }
}


extension Piece: Equatable {
    public static func == (lhs: Piece, rhs: Piece) -> Bool {
        return lhs.type == rhs.type
    }
}
