
import UIKit

protocol VenueDetailCellProvider {
    func register(collectionView: UICollectionView)
    func provides(venue: VenueViewModel) -> Bool
    func cellForType(collectionView: UICollectionView, indexPath: NSIndexPath, venue: VenueViewModel, type: DetailCellType) -> DetailCell
    func sizeForItem(ad: VenueViewModel, inset: UIEdgeInsets) -> CGSize
    
    var type: DetailCellType { get }
    var width: CGFloat { get }
}

extension VenueDetailCellProvider {
    
    var width : CGFloat {
        return UIScreen.mainScreen().bounds.width
    }
    
    func provides(venue: VenueViewModel) -> Bool {
        return true
    }
}
