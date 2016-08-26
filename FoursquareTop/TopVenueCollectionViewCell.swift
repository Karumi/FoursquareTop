
import UIKit

let TopVenueCollectionViewCellReuseIdentifier = "TopVenueCollectionViewCellReuseIdentifier"

class TopVenueCollectionViewCell : UICollectionViewCell {
    
    @IBOutlet private weak var priceLabel: UILabel!
    @IBOutlet private weak var ratingLabel: UILabel!
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var typeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        priceLabel.textColor = .whiteColor()
        priceLabel.font = UIFont.small
        priceLabel.backgroundColor = UIColor.ftopGreen
        ratingLabel.textColor = .whiteColor()
        ratingLabel.font = UIFont.small
        ratingLabel.backgroundColor = UIColor.ftopBlue
        
        nameLabel.textColor = .darkTextPrimary
        nameLabel.font = UIFont.bigBold
        typeLabel.textColor = .darkTextSecondary
        typeLabel.font = UIFont.regular
    }
    
    func configure(withVenue venue: VenueViewModel) {
        setValueOrHide(priceLabel, value: venue.formattedPrice)
        setValueOrHide(ratingLabel, value: venue.formattedRating)
        
        nameLabel.text = venue.name
        typeLabel.text = venue.categories.map { $0.names.get(forType: .Regular) }.joinWithSeparator(", ")
    }
    
    private func setValueOrHide(label: UILabel, value: String?) {
        if let value = value {
            label.text = value
            label.hidden = false
        } else {
            label.hidden = true
        }
    }
}
