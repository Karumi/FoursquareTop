
import UIKit

enum DetailCellType {
    case Gallery
    
    var heightForCell: CGFloat {
        switch self {
        case .Gallery:
            return 200
        }
    }
}

class VenueDetailCollectionViewDataSource : NSObject, UICollectionViewDataSource {
    
    var venue: VenueViewModel? {
        didSet {
            configureCellsForVenue()
        }
    }
    private var cells: [DetailCellType] = []
    
    func registerCells(collectionView: UICollectionView) {
        collectionView.registerNib(
            UINib(nibName: "VenueDetailGalleryCollectionViewCell", bundle: NSBundle.mainBundle()),
            forCellWithReuseIdentifier: VenueDetailGalleryCollectionViewCellReusdeIdentifier
        )
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let _ = venue else {
            return 0
        }
        
        return cells.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(VenueDetailGalleryCollectionViewCellReusdeIdentifier, forIndexPath: indexPath) as! VenueDetailGalleryCollectionViewCell
        
        cell.configure(withVenue: venue!)
        
        return cell
    }
    
    func cellTypeAtIndexPath(indexPath: NSIndexPath) -> DetailCellType {
        return cells[indexPath.item]
    }
    
    private func configureCellsForVenue() {
        guard let _ = venue else {
            return
        }
        
        cells = [.Gallery]
    }
}