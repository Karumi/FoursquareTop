
import UIKit

class VenueDetailTitleView : CustomView {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    
    func configure(withVenue venue: VenueViewModel) {
        nameLabel.font = UIFont.minimum
        categoryLabel.font = UIFont.minimumBold
        
        nameLabel.text = venue.name
        categoryLabel.text = venue.formattedCategories
    }
    
    override func intrinsicContentSize() -> CGSize {
        let nameSize = nameLabel.intrinsicContentSize()
        let categorySize = categoryLabel.intrinsicContentSize()
        
        return CGSize(
            width: max(nameSize.width, categorySize.width),
            height: nameSize.height + categorySize.height + 6
        )
    }
}