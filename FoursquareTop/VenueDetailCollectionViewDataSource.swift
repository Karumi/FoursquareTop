
import UIKit

class VenueDetailCollectionViewDataSource : NSObject, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    var venue: VenueViewModel? {
        didSet {
            configureCellsForVenue()
        }
    }
    
    var photoIndex: Int = 0
    
    private var cellTypes: [DetailCellType] = []
    
    private let providers: [VenueDetailCellProvider]
    
    var galleryCell: VenueDetailGalleryCollectionViewCell?
    var informationCell: VenueDetailInformationCollectionViewCell?
    
    init(providers: [VenueDetailCellProvider]) {
        self.providers = providers
        
        super.init()
    }
    
    func registerCells(collectionView: UICollectionView) {
        providers.forEach { $0.register(collectionView) }
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let _ = venue else {
            return 0
        }
        
        return cellTypes.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        guard let venue = venue else {
            return UICollectionViewCell()
        }
        
        let type = cellTypeAtIndexPath(indexPath)
        let provider = providers.filter { $0.type == type }.first
        
        let cell = provider?.cellForType(collectionView, indexPath: indexPath, venue: venue, type: type) ?? UICollectionViewCell()
        
        // TODO: How to do this better avoiding the type check?
        if let cell = cell as? VenueDetailGalleryCollectionViewCell {
            galleryCell = cell
        }
        
        if let cell = cell as? VenueDetailInformationCollectionViewCell {
            informationCell = cell
        }
        
        return cell
    }
    
    // MARK: UICollectionViewDelegateFlowLayout
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        guard let venue = venue else {
            return .zero
        }
        let type = cellTypeAtIndexPath(indexPath)
        let provider = providers.filter { $0.type == type }.first
        
        return provider?.sizeForItem(venue, inset: UIEdgeInsetsZero) ?? CGSize(width: 0, height: 0)
    }
    
    // MARK: Private
    
    private func cellTypeAtIndexPath(indexPath: NSIndexPath) -> DetailCellType {
        return cellTypes[indexPath.item]
    }
    
    private func configureCellsForVenue() {
        guard let venue = venue else {
            return
        }
        
        cellTypes = [.Gallery, .Information]
        
        if venue.hasSecondaryActions {
            cellTypes.insert(.Actions, atIndex: 1)
        }
        
        if !venue.tips.isEmpty {
            cellTypes.append(.Tips)
        }
    }
}