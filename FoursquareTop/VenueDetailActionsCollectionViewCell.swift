
import UIKit

let VenueDetailActionsCollectionViewCellReuseIdentifier = "VenueDetailActionsCollectionViewCellReuseIdentifier"

class VenueDetailActionsCollectionViewCell : DetailCell {
    
    @IBOutlet private weak var stackView: UIStackView!
    
    weak var delegate: VenueDetailActionsCollectionViewCellDelegate?
    
    override func configure(withVenue venue: VenueViewModel) {
        super.configure(withVenue: venue)
        
        stackView.subviews.forEach { $0.removeFromSuperview() }
        
        if let _ = venue.menuURL {
            let button = UIButton()
            button.setTitle(
                tr(.VenueDetailSeeMenu),
                forState: .Normal
            )
            button.backgroundColor = UIColor(named: .FtopYellow)
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