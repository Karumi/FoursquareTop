
import Foundation
import UIKit

@IBDesignable
class LoadingView : CustomView {
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var loadingLabel: UILabel!
    
    @IBInspectable var loadingColor: UIColor? = nil {
        didSet {
            activityIndicator.color = loadingColor
            loadingLabel.textColor = loadingColor
        }
    }
    
    @IBInspectable var loadingMessage: String? = nil {
        didSet {
            loadingLabel.text = loadingMessage
            loadingLabel.hidden = false
        }
    }
}