
import UIKit

let VenueDetailInformationCollectionViewCellReuseIdentifier = "VenueDetailInformationCollectionViewCellReuseIdentifier"

class VenueDetailInformationCollectionViewCell : UICollectionViewCell, DetailCell {
    
    @IBOutlet private weak var addressLabel: UILabel!
    @IBOutlet private weak var mapImageView: UIImageView!
    @IBOutlet private weak var statusLabel: UILabel!
    @IBOutlet private weak var ratingLabel: UILabel!
    @IBOutlet private weak var priceLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        addressLabel.font = .bigBold
        addressLabel.textColor = .darkTextPrimary
        
        statusLabel.font = .regular
        statusLabel.textColor = .darkTextSecondary
    }
    
    func configure(withVenue venue: VenueViewModel) {
        addressLabel.text = venue.address
        statusLabel.text = venue.status
        ratingLabel.text = venue.formattedRating
        priceLabel.text = venue.formattedPrice
        
        venue.getMapSnapshot { [weak self] image in
            let mask = CALayer()
            mask.contents = UIImage(named: "alpha")!.CGImage
            mask.frame = CGRectMake(0, 0, UIScreen.mainScreen().bounds.width, 200)
            self?.mapImageView.layer.mask = mask
            self?.mapImageView.layer.masksToBounds = true
            
            self?.mapImageView.image = image
            UIView.animateWithDuration(0.1) {
                self?.mapImageView.alpha = 1
            }
        }
    }
}