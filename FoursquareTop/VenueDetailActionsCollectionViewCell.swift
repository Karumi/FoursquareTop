
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
        
        if let _ = venue.phone {
            let button = UIButton()
            button.setTitle("Call", forState: .Normal)
            button.backgroundColor = UIColor.ftopOrange
            button.addTarget(
                self,
                action: #selector(callButtonTapped),
                forControlEvents: .TouchUpInside
            )
            stackView.addArrangedSubview(button)
        }
    }
    
    func callButtonTapped() {
        delegate?.venueDetailCellDidSelectCall()
    }
    
    func menuButtonTapped() {
        delegate?.venueDetailCellDidSelectMenu()
    }
}

protocol VenueDetailActionsCollectionViewCellDelegate : class {
    func venueDetailCellDidSelectCall()
    func venueDetailCellDidSelectMenu()
}