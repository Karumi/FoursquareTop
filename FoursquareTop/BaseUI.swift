import Foundation

protocol BaseUI : class {
    var showingEmptyCase : Bool { get set }
    func showDefaultConnectionErrorMessage()
    func showMessage(message: String)
    
    var loading : Bool { get set }
    var presenter: Presenter? { get }
    
    func showError(errorHappened: Bool)
    func showError()
    func showError(message message: String)
    func hideError()
}

extension BaseUI {
    func showMessage(message: String) {}
}
