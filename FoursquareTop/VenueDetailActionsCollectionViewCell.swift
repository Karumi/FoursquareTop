
import UIKit

let VenueDetailActionsCollectionViewCellReuseIdentifier = "VenueDetailActionsCollectionViewCellReuseIdentifier"

class VenueDetailActionsCollectionViewCell : UICollectionViewCell, DetailCell {
    
    @IBOutlet private weak var stackView: UIStackView!
    
    func configure(withVenue venue: VenueViewModel) {
        stackView.subviews.forEach { $0.removeFromSuperview() }
        
        if let _ = venue.menuURL {
            let button = UIButton()
            button.setTitle("See menu", forState: .Normal)
            button.backgroundColor = UIColor.ftopYellow
            button.sizeToFit()
            stackView.addArrangedSubview(button)
        }
        
        if let _ = venue.reservationsURL {
            let button = UIButton()
            button.setTitle("Make reservation", forState: .Normal)
            button.backgroundColor = UIColor.ftopOrange
            stackView.addArrangedSubview(button)
        }
    }
}