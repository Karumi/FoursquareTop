
import UIKit

let VenueDetailInformationCollectionViewCellReuseIdentifier = "VenueDetailInformationCollectionViewCellReuseIdentifier"

class VenueDetailInformationCollectionViewCell : DetailCell {
    
    @IBOutlet private weak var addressLabel: UILabel!
    @IBOutlet private weak var mapImageView: UIImageView!
    @IBOutlet private weak var statusLabel: UILabel!
    @IBOutlet private weak var ratingLabel: UILabel!
    @IBOutlet private weak var priceLabel: UILabel!
    @IBOutlet private weak var activityIndicator: UIActivityIndicatorView!
    
    weak var delegate: VenueDetailInformationDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        addressLabel.font = .bigBold
        addressLabel.textColor = UIColor(named: .DarkTextPrimary)
        
        statusLabel.font = .regular
        statusLabel.textColor = UIColor(named: .DarkTextSecondary)
        
        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(mapTapped)))
        
        addressLabel.accessibilityLabel = tr(.VenueDetailAddressAccessibilityLabel)
        statusLabel.accessibilityLabel = tr(.VenueDetailStatusAccessibilityLabel)
        ratingLabel.accessibilityLabel = tr(.VenueDetailRatingAccessibilityLabel)
        priceLabel.accessibilityLabel = tr(.VenueDetailPricingAccessibilityLabel)
    }
    
    override func configure(withVenue venue: VenueViewModel) {
        super.configure(withVenue: venue)
        
        addressLabel.text = venue.address
        statusLabel.text = venue.status
        ratingLabel.text = venue.formattedRating
        priceLabel.text = venue.formattedPrice
        
        activityIndicator.startAnimating()
    }
    
    func showMap(image: UIImage) {
        let mask = CALayer()
        mask.contents = UIImage(asset: .Bg_map_alpha)!.CGImage
        mask.frame = CGRectMake(0, 0, UIScreen.mainScreen().bounds.width, 200)
        mapImageView.layer.mask = mask
        mapImageView.layer.masksToBounds = true

        mapImageView.image = image
        activityIndicator.stopAnimating()
        UIView.animateWithDuration(0.1) {
            self.mapImageView.alpha = 1
        }
    }
    
    func mapTapped() {
        delegate?.venueDetailInformationDidTapMap()
    }
}

protocol VenueDetailInformationDelegate : class {
    func venueDetailInformationDidTapMap()
}
