
import UIKit

protocol BaseUI : class {
    var width : CGFloat { get }
    var loading : Bool { get set }
    var presenter: Presenter? { get }
    var contentView: UIView { get }
    
    func showEmptyCase(message message: String)
    func showError(message message: String)
    
}
