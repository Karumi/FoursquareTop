
import UIKit

struct VenueDetailCollectionViewCellHeightCalculator {
    
    private let availableWidth: CGFloat
    
    init(availableWidth: CGFloat) {
        self.availableWidth = availableWidth
    }
    
    func heightForCell(forType type: DetailCellType, venue: VenueViewModel? = nil) -> CGFloat {
        switch type {
        case .Gallery:
            return 200
        case .Actions:
            guard let venue = venue else {
                return 0
            }
            return venue.hasSecondaryActions ? 60 : 0
        case .Information:
            return 150
        case .Tips:
            guard let venue = venue where !venue.topTips.isEmpty else {
                return 0
            }
            
            return venue.topTips.reduce(0) { (acc, tip) in
                return acc + VenueDetailTipCollectionViewCell.heightForTip(tip, inWidth: self.availableWidth)
            } + (CGFloat(venue.topTips.count) * VenueDetailTipCollectionViewCell.tipsSeparationHeight) + VenueDetailTipCollectionViewCell.tipsSeparationHeight
            
        case .EmptySpace(let height):
            return height
        }
    }
    
}