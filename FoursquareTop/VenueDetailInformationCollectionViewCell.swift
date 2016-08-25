
import UIKit

let VenueDetailInformationCollectionViewCellReuseIdentifier = "VenueDetailInformationCollectionViewCellReuseIdentifier"

class VenueDetailInformationCollectionViewCell : UICollectionViewCell, DetailCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var mapImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        nameLabel.font = UIFont.bigBold
        nameLabel.textColor = UIColor.darkTextPrimary
        typeLabel.font = UIFont.regular
        typeLabel.textColor = UIColor.darkTextSecondary
    }
    
    func configure(withVenue venue: VenueViewModel) {
        nameLabel.text = venue.name
        typeLabel.text = venue.formattedCategories
        
        venue.getMapSnapshot { [weak self] image in
            self?.mapImageView.image = image
            UIView.animateWithDuration(0.1) {
                self?.mapImageView.alpha = 1
            }
        }
    }
}