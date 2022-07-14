
import Foundation

enum ViewState {
    case idle
    case loading
    case failed(Error)
    case loaded
}
