
import UIKit
import NYTPhotoViewer

class VenuePhotoViewModel : NSObject, NYTPhoto {

    let identifier: String
    let url: NSURL?
    var image: UIImage?
    var imageData: NSData? = nil
    var placeholderImage: UIImage? = nil
    let attributedCaptionTitle: NSAttributedString? = nil
    let attributedCaptionSummary: NSAttributedString? = nil
    let attributedCaptionCredit: NSAttributedString? = nil
    
    init(identifier: String, url: NSURL?, image: UIImage?) {
        self.identifier = identifier
        self.url = url
        self.image = image
        super.init()
    }
}