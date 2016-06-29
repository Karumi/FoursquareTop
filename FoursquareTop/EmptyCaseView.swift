
import UIKit

class EmptyCaseView : CustomView {
    
    @IBOutlet weak var topImageView: UIImageView!
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var bottomImageView: UIImageView!
    @IBOutlet weak var topImageViewVerticalMarginToLabelConstaint: NSLayoutConstraint!
    
    @IBInspectable var topEmptyCaseImage: String? = nil {
        didSet {
            if let imageName = topEmptyCaseImage {
                topImageView.image = UIImage(named: imageName)
            }
        }
    }
    
    @IBInspectable var emptyCaseMessage: String? = nil {
        didSet {
            if let emptyCaseMessage = emptyCaseMessage {
                let style = NSMutableParagraphStyle()
                style.lineSpacing = 10
                style.alignment = .Center
                
                let attributes = [NSParagraphStyleAttributeName : style]
                
                label.attributedText = NSAttributedString(string: emptyCaseMessage, attributes:attributes)
            }
        }
    }
    
    @IBInspectable var bottomEmptyCaseImage: String? = nil {
        didSet {
            if let imageName = topEmptyCaseImage {
                topImageView.image = UIImage(named: imageName)
            }
        }
    }
    
    override func pointInside(point: CGPoint, withEvent event: UIEvent?) -> Bool {
        return false
    }
}