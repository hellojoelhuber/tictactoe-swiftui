//
//  TokenAuth.swift
//  TicTacToeSwiftUI
//
//  Created by Joel Huber on 5/31/22.
//

import Foundation

final class Token: Codable {
    var id: UUID?
    var value: String

    init(value: String) {
        self.value = value
    }
}
