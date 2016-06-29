
import UIKit

class FTViewController : UIViewController, BaseUI {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        presenter?.viewWillAppear()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        presenter?.viewDidAppear()
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        presenter?.viewWillDisappear()
    }
    
    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
        presenter?.viewWillDisappear()
    }
    
    // MARK: UI
    var loading = false {
        didSet {
            if loading {
                hideError()
                removeEmptyCaseView()
                addLoadingView()
                adjustLoadingViewPosition()
            } else {
                removeLoadingView()
            }
        }
    }
    
    var presenter: Presenter? {
        return nil
    }
    
    func showError() {
        showError(true)
    }
    
    func showError(errorHappened: Bool) {
        if errorHappened {
            addConnectionErrorView()
            adjustConnectionErrorViewPosition()
        }
    }
    
    func showDefaultConnectionErrorMessage() {
//        let message = NSLocalizedString("Toast.Connection.Error.Message", comment: "Toast message - Connection lost")
//        let connectionErrorToast = Toast.makeText(message)
//        connectionErrorToast.setGravity(ToastGravityBottom)
//        connectionErrorToast.show()
    }
    
    func showError(message message: String) {
        // Clear any loader
        loading = false
        
        // Clear any other previous hud
//        SVProgressHUD.dismiss()
//        SVProgressHUD.showErrorWithStatus(message)
    }
    
    func hideError() {
        hideError(animated: true)
    }
    
    func hideError(animated animated: Bool) {
        removeConnectionErrorView()
//        SVProgressHUD.dismiss()
    }
    
    var showingEmptyCase = false {
        didSet {
            if showingEmptyCase {
                hideError()
                if let emptyCaseView = emptyCaseView {
                    emptyCaseView.hidden = false
                    if !view.subviews.contains(emptyCaseView) {
                        view.addSubview(emptyCaseView)
                        adjustEmptyCaseViewPosition()
                    }
                }
            } else {
                removeEmptyCaseView()
            }
        }
    }
    
    // MARK: Loading
    func removeLoadingView() {
        loadingView?.removeFromSuperview()
        loadingView?.hidden = true
    }
    
    lazy var loadingView: UIView? = {
        let loadingView = LoadingView()
        loadingView.accessibilityLabel = NSLocalizedString("Loading", comment: "Loading")
        return loadingView
    }()
    
    // MARK: Empty Case
    func removeEmptyCaseView() {
        emptyCaseView?.removeFromSuperview()
        emptyCaseView?.hidden = true
    }
    
    func adjustEmptyCaseViewPosition() {
//        emptyCaseView?.autoSetDimensionsToSize(CGSizeMake(247, 311))
//        emptyCaseView?.autoCenterInSuperview()
    }
    
    lazy var emptyCaseView: UIView? = {
        return EmptyCaseView()
    }()
    
    // MARK: Loading
    func addLoadingView() {
        if let loadingView = loadingView {
            loadingView.hidden = false
            if !view.subviews.contains(loadingView) {
                view.addSubview(loadingView)
            }
        }
    }
    
    func adjustLoadingViewPosition() {
//        loadingView?.autoSetDimensionsToSize(CGSizeMake(100, 100))
//        loadingView?.autoCenterInSuperview()
    }
    
    // MARK: Connection Error Case
    func addConnectionErrorView() {
        if let connectionErrorView = connectionErrorView where !view.subviews.contains(connectionErrorView)  {
            view.addSubview(connectionErrorView)
            connectionErrorView.hidden = false
        }
    }
    
    func adjustConnectionErrorViewPosition() {
//        connectionErrorView?.autoSetDimensionsToSize(CGSizeMake(250, 313))
//        connectionErrorView?.autoCenterInSuperview()
    }
    
    func removeConnectionErrorView() {
        connectionErrorView?.removeFromSuperview()
        connectionErrorView?.hidden = true
    }
    
    lazy var connectionErrorView: UIView? = {
        let connectionErrorView = ConnectionErrorView()
        connectionErrorView.accessibilityLabel = NSLocalizedString("ConnectivityError", comment: "Connectivity error")
        return connectionErrorView
    }()
}