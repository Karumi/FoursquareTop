
import UIKit

class VenueDetailCollectionViewDataSource : NSObject, UICollectionViewDataSource {
    
    var venue: VenueViewModel? {
        didSet {
            configureCellsForVenue()
        }
    }
    private var cells: [DetailCellType] = []
    private weak var detailActionsCelleDelegate: VenueDetailActionsCollectionViewCellDelegate?
    
    init(detailActionsCellDelegate: VenueDetailActionsCollectionViewCellDelegate) {
        self.detailActionsCelleDelegate = detailActionsCellDelegate
        super.init()
    }
    
    func registerCells(collectionView: UICollectionView) {
        DetailCellType.all.forEach { $0.registerCells(forCollectionView: collectionView) }
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let _ = venue else {
            return 0
        }
        
        return cells.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cellType = cells[indexPath.item]
        let cell = cellType.cell(forCollectionView: collectionView, indexPath: indexPath)
        
        if let c = cell as? VenueDetailActionsCollectionViewCell {
            c.delegate = detailActionsCelleDelegate
        }
        
        cell.configure(withVenue: venue!)
        
        return cell as! UICollectionViewCell
    }
    
    func cellTypeAtIndexPath(indexPath: NSIndexPath) -> DetailCellType {
        return cells[indexPath.item]
    }
    
    private func configureCellsForVenue() {
        guard let venue = venue else {
            return
        }
        
        cells = [.Gallery, .Information]
        
        if venue.hasSecondaryActions {
            cells.insert(.Actions, atIndex: 1)
        }
    }
}