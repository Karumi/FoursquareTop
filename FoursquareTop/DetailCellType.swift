
import UIKit

enum DetailCellType {
    case Gallery
    case Actions
    
    static var all: [DetailCellType] = [.Gallery, .Actions]
    
    var heightForCell: CGFloat {
        switch self {
        case .Gallery:
            return 200
        case .Actions:
            return 60
        }
    }
    
    private var cellIdentification: (String, String) {
        switch self {
        case .Gallery:
            return ("VenueDetailGalleryCollectionViewCell", VenueDetailGalleryCollectionViewCellReusdeIdentifier)
        case .Actions:
            return ("VenueDetailActionsCollectionViewCell", VenueDetailActionsCollectionViewCellReuseIdentifier)
        }
    }
    
    func cell(forCollectionView collectionView: UICollectionView, indexPath: NSIndexPath) -> DetailCell {
        switch self {
        case .Gallery:
            return collectionView.dequeueReusableCellWithReuseIdentifier(VenueDetailGalleryCollectionViewCellReusdeIdentifier, forIndexPath: indexPath) as! VenueDetailGalleryCollectionViewCell
        case .Actions:
            return collectionView.dequeueReusableCellWithReuseIdentifier(VenueDetailActionsCollectionViewCellReuseIdentifier, forIndexPath: indexPath) as! VenueDetailActionsCollectionViewCell
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