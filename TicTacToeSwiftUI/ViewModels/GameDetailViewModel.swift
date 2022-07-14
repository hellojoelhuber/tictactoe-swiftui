
import SwiftUI
import TicTacToeCore

class GameDetailViewModel: ObservableObject {
//    @Published var showSubmittingModal: Bool = false

    @Published private(set) var state = ViewState.idle
    
//    private let player: Player // TODO: This needs to be sourced from a globally-accessible variable, not passed in.
    let game: GameDTO
    @Published var gameBoard = [Square]()
    private let loader: GameRequest
    private let poster: GameRequest
    var mostRecentTurn: Int = 0
    var actionHistory = [GameActionDTO]()

    init(game: GameDTO) {
        self.game = game
//        self.player = player
        self.loader = GameRequest(httpMethod: "GET",
                                  resourcePath: "\(game.id.description)/")
        self.poster = GameRequest(httpMethod: "POST",
                                  resourcePath: "\(game.id.description)/action")
        createBoard()
    }
    
    func createBoard() {
        for square in 0..<(game.boardRows * game.boardColumns) {
            gameBoard.append(Square(id: square, piece: nil))
        }
    }
    
    func incrementBoardState() {
        print("Incrementing from \(mostRecentTurn)")
        if mostRecentTurn < actionHistory.count {
            let id = mostRecentTurn % 2 + 1
            gameBoard[actionHistory[mostRecentTurn].action].piece = actionHistory[mostRecentTurn].playerID == game.createdBy.id ? Piece(id: id, type: .home) : Piece(id: id, type: .visitor)
            mostRecentTurn += 1
        }
    }
    
    // loader
    func loadGame(auth: Auth) {
        state = .loading
        
        loader.getActions(since: mostRecentTurn, auth: auth, completion: { result in
            switch result {
            case .success(let actions):
                DispatchQueue.main.async {
                    print("Received \(actions.count) actions")
                    self.actionHistory.append(contentsOf: actions)// = actions
                    print("Actions recorded: \(self.actionHistory.count)")
                    self.state = .loaded
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self.state = .failed(error)
                }
            }
        })
    }
    
    // poster / submitter
    func submitAction(action: Int, auth: Auth) {
        poster.submitAction(action: SubmitGameAction(action: action), auth: auth, completion: { result in
            switch result {
            case .success:
                let defaults = UserDefaults.standard
                var playerID: UUID? = nil
                if let savedUserData = defaults.object(forKey: "loggedInPlayer") as? Data {
                    let decoder = JSONDecoder()
                    if let savedUser = try? decoder.decode(PlayerDTO.self, from: savedUserData) {
                        playerID = savedUser.id
                    }
                }
//                let player: Player = UserDefaults.value(forKey: "loggedInPlayer") as! Player
                self.actionHistory.append(GameActionDTO(playerID: playerID!, //self.player.id!,
                                                             turnNumber: (self.mostRecentTurn+1),
                                                             action: action))
            case .failure:
                print("Failure")
            }
        })
    }
}
