
import UIKit

class ConnectionErrorView : CustomView {
    
    @IBOutlet weak var message: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    @IBInspectable var connectionErrorImage: String? = nil {
        didSet {
            if let imageName = connectionErrorImage {
                imageView.image = UIImage(named: imageName)
            }
        }
    }
    
    @IBInspectable var connectionErrorMessage: String? = nil {
        didSet {
            message.text = connectionErrorMessage
        }
    }
    
    override func pointInside(point: CGPoint, withEvent event: UIEvent?) -> Bool {
        return false
    }
}
