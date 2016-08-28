
import UIKit

let VenueDetailInformationCollectionViewCellReuseIdentifier = "VenueDetailInformationCollectionViewCellReuseIdentifier"

class VenueDetailInformationCollectionViewCell : UICollectionViewCell, DetailCell {
    
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
        addressLabel.textColor = .darkTextPrimary
        
        statusLabel.font = .regular
        statusLabel.textColor = .darkTextSecondary
        
        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(mapTapped)))
    }
    
    func configure(withVenue venue: VenueViewModel) {
        addressLabel.text = venue.address
        statusLabel.text = venue.status
        ratingLabel.text = venue.formattedRating
        priceLabel.text = venue.formattedPrice
        
        activityIndicator.startAnimating()
        
        venue.getMapSnapshot { [weak self] image in
            let mask = CALayer()
            mask.contents = UIImage(named: "alpha")!.CGImage
            mask.frame = CGRectMake(0, 0, UIScreen.mainScreen().bounds.width, 200)
            self?.mapImageView.layer.mask = mask
            self?.mapImageView.layer.masksToBounds = true
            
            self?.mapImageView.image = image
            self?.activityIndicator.stopAnimating()
            UIView.animateWithDuration(0.1) {
                self?.mapImageView.alpha = 1
            }
        }
    }
    
    func mapTapped() {
        delegate?.venueDetailInformationDidTapMap()
    }
}

protocol VenueDetailInformationDelegate : class {
    func venueDetailInformationDidTapMap()
}