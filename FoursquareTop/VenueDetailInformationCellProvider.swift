
import UIKit

class VenueDetailInformationCellProvider : VenueDetailCellProvider {
    
    let type = DetailCellType.Information
    
    static let height: CGFloat = 150
    
    private weak var delegate: VenueDetailInformationDelegate?
    
    init(delegate: VenueDetailInformationDelegate) {
        self.delegate = delegate
    }
    
    // MARK: AdDetailCellProvider
    func register(collectionView: UICollectionView) {
        collectionView.registerCell(
            nibName: "VenueDetailInformationCollectionViewCell",
            forCellReuseIdentifier: VenueDetailInformationCollectionViewCellReuseIdentifier
        )
    }
    
    func provides(venue: VenueViewModel) -> Bool {
        return venue.hasSecondaryActions
    }
    
    func cellForType(collectionView: UICollectionView, indexPath: NSIndexPath, venue: VenueViewModel, type: DetailCellType) -> DetailCell {
        let cell = collectionView.dequeueCell(reuseIdentifier: VenueDetailInformationCollectionViewCellReuseIdentifier, forIndexPath: indexPath) as VenueDetailInformationCollectionViewCell
        
        cell.delegate = delegate
        cell.configure(withVenue: venue)
        
        return cell
    }
    
    func sizeForItem(venue: VenueViewModel, inset: UIEdgeInsets) -> CGSize {
        return CGSize(width: width, height: VenueDetailInformationCellProvider.height)
    }
}
