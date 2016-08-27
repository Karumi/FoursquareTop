
import UIKit

class FTViewController : UIViewController, BaseUI, ErrorViewDelegate {
    
    lazy var loadingView: LoadingView? = {
        let loadingView = LoadingView()
        loadingView.accessibilityLabel = NSLocalizedString("Loading", comment: "Loading")
        return loadingView
    }()
    
    lazy var emptyCaseView: ErrorView? = {
        let view = ErrorView()
        view.delegate = self
        view.topErrorViewImage = "ic_sad"
        
        return view
    }()
    
    lazy var errorView: ErrorView? = {
        let view = ErrorView()
        view.delegate = self
        view.topErrorViewImage = "ic_embarrassed"
        
        return view
    }()
    
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
            removeAllSupplementaryViews()
            
            if loading {
                addLoadingView()
            }
        }
    }
    
    var presenter: Presenter? {
        return nil
    }
    
    func showError(message message: String) {
        removeAllSupplementaryViews()
        
        addErrorView()
        
        errorView?.errorMessage = message
    }
    
    func addErrorView() {
        if let errorView = errorView where !view.subviews.contains(errorView) {
            pinViewToSuperView(errorView)
        }
    }
    
    private func removeErrorView() {
        errorView?.removeFromSuperview()
    }
    
    func showEmptyCase(message message: String) {
        removeAllSupplementaryViews()
        
        addEmptyCaseView()
        
        emptyCaseView?.errorMessage = message
    }
    
    // MARK: ErrorViewDelegate
    func didTapErrorView() {
        removeAllSupplementaryViews()
        presenter?.retry()
    }
    
    // MARK: Loading
    private func removeLoadingView() {
        loadingView?.removeFromSuperview()
    }
    
    // MARK: Empty Case
    func addEmptyCaseView() {
        if let emptyCaseView = emptyCaseView where !view.subviews.contains(emptyCaseView) {
            pinViewToSuperView(emptyCaseView)
        }
    }
    
    private func removeEmptyCaseView() {
        emptyCaseView?.removeFromSuperview()
    }
    
    // MARK: Loading
    func addLoadingView() {
        if let loadingView = loadingView {
            loadingView.hidden = false
            if !view.subviews.contains(loadingView) {
                pinViewToSuperView(loadingView)
            }
        }
    }
    
    private func removeAllSupplementaryViews() {
        removeEmptyCaseView()
        removeLoadingView()
        removeErrorView()
    }
    
    private func pinViewToSuperView(view: UIView) {
        view.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(view)
        
        view.topAnchor.constraintEqualToAnchor(topLayoutGuide.bottomAnchor).active = true
        view.bottomAnchor.constraintEqualToAnchor(bottomLayoutGuide.topAnchor).active = true
        view.leftAnchor.constraintEqualToAnchor(self.view.leftAnchor).active = true
        view.rightAnchor.constraintEqualToAnchor(self.view.rightAnchor).active = true
    }
}