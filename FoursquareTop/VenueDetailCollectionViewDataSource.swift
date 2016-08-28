
import UIKit

class VenueDetailCollectionViewDataSource : NSObject, UICollectionViewDataSource {
    
    var venue: VenueViewModel? {
        didSet {
            configureCellsForVenue()
        }
    }
    
    var photoIndex: Int = 0
    
    private var allSupportedCells: [DetailCellType] = [.Gallery, .Actions, .Information, .Tips, .EmptySpace(16)]
    private var cells: [DetailCellType] = []
    private weak var detailActionsCelleDelegate: VenueDetailActionsCollectionViewCellDelegate?
    private weak var detailInformationDelegate: VenueDetailInformationDelegate?
    private weak var galleryDelegate: VenueDetailGalleryCollectionViewCellDelegate?
    
    var galleryHeader: VenueDetailGalleryCollectionViewCell?
    
    init(detailActionsCellDelegate: VenueDetailActionsCollectionViewCellDelegate, detailInformationDelegate: VenueDetailInformationDelegate, galleryDelegate: VenueDetailGalleryCollectionViewCellDelegate) {
        self.detailActionsCelleDelegate = detailActionsCellDelegate
        self.detailInformationDelegate = detailInformationDelegate
        self.galleryDelegate = galleryDelegate
        
        super.init()
    }
    
    func registerCells(collectionView: UICollectionView) {
        allSupportedCells.forEach {
            let (nibName, reuseIdentifier) = self.getCellIdentification(forType: $0)
            
            collectionView.registerNib(
                UINib(nibName: nibName, bundle: NSBundle.mainBundle()),
                forCellWithReuseIdentifier: reuseIdentifier
            )
        }
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let _ = venue else {
            return 0
        }
        
        return cells.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cellType = cells[indexPath.item]
        let cell = getCell(forType: cellType, forCollectionView: collectionView, indexPath: indexPath)
        
        if let c = cell as? VenueDetailGalleryCollectionViewCell {
            c.delegate = galleryDelegate
            galleryHeader = c
        }
        
        if let c = cell as? VenueDetailActionsCollectionViewCell {
            c.delegate = detailActionsCelleDelegate
        }
        
        if let c = cell as? VenueDetailInformationCollectionViewCell {
            c.delegate = detailInformationDelegate
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
        
        if !venue.tips.isEmpty {
            cells.append(.Tips)
        }
    }
    
    private func getCell(forType type: DetailCellType, forCollectionView collectionView: UICollectionView, indexPath: NSIndexPath) -> DetailCell {
        let (_, reuseIdentifier) = getCellIdentification(forType: type)
        
        switch type {
        case .Gallery:
            return collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as! VenueDetailGalleryCollectionViewCell
        case .Actions:
            return collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as! VenueDetailActionsCollectionViewCell
        case .Information:
            return collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as! VenueDetailInformationCollectionViewCell
        case .Tips:
            return collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as! VenueDetailTipCollectionViewCell
        case .EmptySpace(_):
            return collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as! VenueDetailEmptySpaceCollectionViewCell
        }
    }
    
    private func getCellIdentification(forType type: DetailCellType) -> (String, String) {
        switch type {
        case .Gallery:
            return ("VenueDetailGalleryCollectionViewCell", VenueDetailGalleryCollectionViewCellReusdeIdentifier)
        case .Actions:
            return ("VenueDetailActionsCollectionViewCell", VenueDetailActionsCollectionViewCellReuseIdentifier)
        case .Information:
            return ("VenueDetailInformationCollectionViewCell", VenueDetailInformationCollectionViewCellReuseIdentifier)
        case .Tips:
            return ("VenueDetailTipCollectionViewCell", VenueDetailTipCollectionViewCellReuseIdentifier)
        case .EmptySpace(_):
            return ("VenueDetailEmptySpaceCollectionViewCell", VenueDetailEmptySpaceCollectionViewCellReuseIdentifier)
        }
    }
}