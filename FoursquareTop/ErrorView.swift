
import UIKit

class ErrorView : CustomView {
    
    @IBOutlet weak var topImageView: UIImageView!
    @IBOutlet weak var label: UILabel!
    
    weak var delegate: ErrorViewDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        label.font = UIFont.regular
    }
    
    @IBInspectable var topErrorViewImage: String? = nil {
        didSet {
            if let imageName = topErrorViewImage {
                topImageView.image = UIImage(named: imageName)
            }
        }
    }
    
    @IBInspectable var errorMessage: String? = nil {
        didSet {
            if let errorMessage = errorMessage {
                label.text = errorMessage
            }
        }
    }
    
    @IBAction func errorViewTapped(sender: AnyObject) {
        delegate?.didTapErrorView()
    }
}

protocol ErrorViewDelegate : class {
    func didTapErrorView()
}