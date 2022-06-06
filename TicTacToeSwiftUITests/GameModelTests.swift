//
//  GameModelTests.swift
//  TicTacToeSwiftUITests
//
//  Created by Joel Huber on 5/31/22.
//

import XCTest
@testable import TicTacToeSwiftUI

class GameTests: XCTestCase {
    var sut: Game!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        sut = Game(createdBy: UUID.init())
    }

    override func tearDownWithError() throws {
        sut = nil
        try super.tearDownWithError()
    }

    func test_Game_initsDefault_WithRowsAndColumns() throws {
        XCTAssertEqual(sut.boardRows, 3)
        XCTAssertEqual(sut.boardColumns, 3)
        XCTAssertEqual(sut.isComplete, false)
        XCTAssertEqual(sut.completeTurnsCount, 0)
    }
}
