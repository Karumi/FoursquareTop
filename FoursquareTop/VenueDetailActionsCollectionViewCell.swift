
import UIKit

let VenueDetailActionsCollectionViewCellReuseIdentifier = "VenueDetailActionsCollectionViewCellReuseIdentifier"

class VenueDetailActionsCollectionViewCell : UICollectionViewCell, DetailCell {
    
    @IBOutlet private weak var stackView: UIStackView!
    
    weak var delegate: VenueDetailActionsCollectionViewCellDelegate?
    
    func configure(withVenue venue: VenueViewModel) {
        stackView.subviews.forEach { $0.removeFromSuperview() }
        
        if let _ = venue.menuURL {
            let button = UIButton()
            button.setTitle("See menu", forState: .Normal)
            button.backgroundColor = UIColor.ftopYellow
            button.addTarget(
                self,
                action: #selector(menuButtonTapped),
                forControlEvents: .TouchUpInside
            )
            button.sizeToFit()
            stackView.addArrangedSubview(button)
        }
    }
    
    func menuButtonTapped() {
        delegate?.venueDetailCellDidSelectMenu()
    }
}

protocol VenueDetailActionsCollectionViewCellDelegate : class {
    func venueDetailCellDidSelectMenu()
}