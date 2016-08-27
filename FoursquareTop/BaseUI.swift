import Foundation

protocol BaseUI : class {
    var loading : Bool { get set }
    var presenter: Presenter? { get }
    
    func showEmptyCase(message message: String)
    func showError(message message: String)
}
