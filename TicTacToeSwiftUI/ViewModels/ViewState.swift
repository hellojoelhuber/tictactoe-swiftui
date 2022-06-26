//
//  ViewState.swift
//  TicTacToeSwiftUI
//
//  Created by Joel Huber on 6/26/22.
//

import Foundation

enum ViewState {
    case idle
    case loading
    case failed(Error)
    case loaded
}
