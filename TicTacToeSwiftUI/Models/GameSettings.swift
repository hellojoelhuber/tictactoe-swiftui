

import Foundation

struct GameSettings: Codable {
    let rows: Int
    let columns: Int
    let password: String?
    let isMutualFollowsOnly: Bool
    
    init(rows: Int = 3, columns: Int = 3, password: String? = nil, isMutualFollowsOnly: Bool = false) {
        self.rows = rows
        self.columns = columns
        self.password = password
        self.isMutualFollowsOnly = isMutualFollowsOnly
    }
}
