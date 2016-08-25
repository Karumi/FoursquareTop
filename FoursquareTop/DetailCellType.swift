
import UIKit

enum DetailCellType {
    case Gallery
    case Actions
    case Information
    case EmptySpace(CGFloat)
    
    static var all: [DetailCellType] = [.Gallery, .Actions, .Information, .EmptySpace(16)]
    
    func heightForCell(venue: VenueViewModel? = nil) -> CGFloat {
        switch self {
        case .Gallery:
            return 200
        case .Actions:
            guard let venue = venue else {
                return 0
            }
            return venue.hasSecondaryActions ? 60 : 0
        case .Information:
            return 200
        case .EmptySpace(let height):
            return height
        }
    }

    private var cellIdentification: (String, String) {
        switch self {
        case .Gallery:
            return ("VenueDetailGalleryCollectionViewCell", VenueDetailGalleryCollectionViewCellReusdeIdentifier)
        case .Actions:
            return ("VenueDetailActionsCollectionViewCell", VenueDetailActionsCollectionViewCellReuseIdentifier)
        case .Information:
            return ("VenueDetailInformationCollectionViewCell", VenueDetailInformationCollectionViewCellReuseIdentifier)
        case .EmptySpace(_):
            return ("VenueDetailEmptySpaceCollectionViewCell", VenueDetailEmptySpaceCollectionViewCellReuseIdentifier)
        }
    }
    
    func cell(forCollectionView collectionView: UICollectionView, indexPath: NSIndexPath) -> DetailCell {
        let (_, reuseIdentifier) = cellIdentification
        switch self {
        case .Gallery:
            return collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as! VenueDetailGalleryCollectionViewCell
        case .Actions:
            return collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as! VenueDetailActionsCollectionViewCell
        case .Information:
            return collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as! VenueDetailInformationCollectionViewCell
        case .EmptySpace(_):
            return collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as! VenueDetailEmptySpaceCollectionViewCell
        }
    }
    
    func registerCells(forCollectionView collectionView: UICollectionView) {
        let (nibName, reuseIdentifier) = cellIdentification
        
        collectionView.registerNib(
            UINib(nibName: nibName, bundle: NSBundle.mainBundle()),
            forCellWithReuseIdentifier: reuseIdentifier
        )
    }
}