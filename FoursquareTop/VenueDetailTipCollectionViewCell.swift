
import UIKit

let VenueDetailTipCollectionViewCellReuseIdentifier = "VenueDetailTipCollectionViewCellReuseIdentifier"

class VenueDetailTipCollectionViewCell : DetailCell {
    
    @IBOutlet private weak var stackView: UIStackView!
    
    static let tipsSeparationHeight: CGFloat = 10
    private static let horizontalSpacing: CGFloat = 32
    
    static func heightForTip(tip: VenueTipViewModel, inWidth width: CGFloat) -> CGFloat {
        let label = UILabel(frame: CGRect(origin: .zero, size: CGSize(width: width - horizontalSpacing, height: 10000)))
        label.translatesAutoresizingMaskIntoConstraints = false
        configure(label: label, forTip: tip)
        label.sizeToFit()
        
        return label.frame.height
    }
    
    override func configure(withVenue venue: VenueViewModel) {
        super.configure(withVenue: venue)
        
        stackView.subviews.forEach { $0.removeFromSuperview() }
        
        venue.topTips.forEach {
            let label = UILabel()
            label.backgroundColor = UIColor(named: .FtopLightYellow)
            VenueDetailTipCollectionViewCell.configure(label: label, forTip: $0)
            label.textColor = UIColor(named: .DarkTextSecondary)
            
            self.stackView.addArrangedSubview(label)
        }
    }
    
    private static func configure(label label: UILabel, forTip tip: VenueTipViewModel) -> UILabel {
        label.font = UIFont.big
        label.numberOfLines = 0
        label.textAlignment = .Center
        label.lineBreakMode = .ByWordWrapping
        label.text = tip.text
        
        return label
    }
}