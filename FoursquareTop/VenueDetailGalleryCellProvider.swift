
import UIKit

class VenueDetailGalleryCellProvider : VenueDetailCellProvider {
    
    let type = DetailCellType.Gallery
    
    private weak var delegate: VenueDetailGalleryCollectionViewCellDelegate?
    
    init(delegate: VenueDetailGalleryCollectionViewCellDelegate) {
        self.delegate = delegate
    }
    
    // MARK: AdDetailCellProvider
    func register(collectionView: UICollectionView) {
        collectionView.registerCell(
            nibName: "VenueDetailGalleryCollectionViewCell",
            forCellReuseIdentifier: VenueDetailGalleryCollectionViewCellReusdeIdentifier
        )
    }
    
    func cellForType(collectionView: UICollectionView, indexPath: NSIndexPath, venue: VenueViewModel, type: DetailCellType) -> DetailCell {
        let cell = collectionView.dequeueCell(reuseIdentifier: VenueDetailGalleryCollectionViewCellReusdeIdentifier, forIndexPath: indexPath) as VenueDetailGalleryCollectionViewCell
        
        cell.delegate = delegate
        cell.configure(withVenue: venue)
        
        return cell
    }
    
    func sizeForItem(venue: VenueViewModel, inset: UIEdgeInsets) -> CGSize {
        return CGSize(width: width, height: 200)
    }
}
