
import UIKit

class VenueDetailActionsCellProvider : VenueDetailCellProvider {
    
    let type = DetailCellType.Actions
    
    private weak var delegate: VenueDetailActionsCollectionViewCellDelegate?
    
    init(delegate: VenueDetailActionsCollectionViewCellDelegate?) {
        self.delegate = delegate
    }
    
    // MARK: AdDetailCellProvider
    func register(collectionView: UICollectionView) {
        collectionView.registerCell(
            nibName: "VenueDetailActionsCollectionViewCell",
            forCellReuseIdentifier: VenueDetailActionsCollectionViewCellReuseIdentifier
        )
    }
    
    func provides(venue: VenueViewModel) -> Bool {
        return venue.hasSecondaryActions
    }
    
    func cellForType(collectionView: UICollectionView, indexPath: NSIndexPath, venue: VenueViewModel, type: DetailCellType) -> DetailCell {
        let cell = collectionView.dequeueCell(reuseIdentifier: VenueDetailActionsCollectionViewCellReuseIdentifier, forIndexPath: indexPath) as VenueDetailActionsCollectionViewCell
        
        cell.delegate = delegate
        cell.configure(withVenue: venue)
        
        return cell
    }
    
    func sizeForItem(venue: VenueViewModel, inset: UIEdgeInsets) -> CGSize {
        return CGSize(width: width, height: 60)
    }
}
