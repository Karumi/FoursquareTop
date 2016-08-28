
import UIKit

class VenueDetailTipCellProvider : VenueDetailCellProvider {
    
    let type = DetailCellType.Tips
    
    // MARK: AdDetailCellProvider
    func register(collectionView: UICollectionView) {
        collectionView.registerCell(
            nibName: "VenueDetailTipCollectionViewCell",
            forCellReuseIdentifier: VenueDetailTipCollectionViewCellReuseIdentifier
        )
    }
    
    func provides(venue: VenueViewModel) -> Bool {
        return !venue.topTips.isEmpty
    }
    
    func cellForType(collectionView: UICollectionView, indexPath: NSIndexPath, venue: VenueViewModel, type: DetailCellType) -> DetailCell {
        let cell = collectionView.dequeueCell(reuseIdentifier: VenueDetailTipCollectionViewCellReuseIdentifier, forIndexPath: indexPath) as VenueDetailTipCollectionViewCell
        
        cell.configure(withVenue: venue)
        
        return cell
    }
    
    func sizeForItem(venue: VenueViewModel, inset: UIEdgeInsets) -> CGSize {
        let height = venue.topTips.reduce(0) { (acc, tip) in
            return acc + VenueDetailTipCollectionViewCell.heightForTip(tip, inWidth: self.width)
            } + (CGFloat(venue.topTips.count) * VenueDetailTipCollectionViewCell.tipsSeparationHeight) + VenueDetailTipCollectionViewCell.tipsSeparationHeight
        
        return CGSize(width: width, height: height)
    }
}
