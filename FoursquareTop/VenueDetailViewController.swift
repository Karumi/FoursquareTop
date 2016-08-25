
import UIKit

class VenueDetailViewController : FTViewController, VenueDetailUI, UICollectionViewDelegateFlowLayout, VenueDetailActionsCollectionViewCellDelegate {
    
    var venueDetailPresenter: VenueDetailPresenter!
    override var presenter: Presenter? {
        return venueDetailPresenter
    }
    
    private var collectionView: UICollectionView!
    private lazy var dataSource: VenueDetailCollectionViewDataSource = {
        return VenueDetailCollectionViewDataSource(detailActionsCellDelegate: self)
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        automaticallyAdjustsScrollViewInsets = false
        
        initCollectionView()
    }
    
    // MARK: VenueDetailUI
    func showVenue(venue: VenueViewModel) {
        dataSource.venue = venue
        collectionView.reloadData()
        navigationController?.navigationBar.topItem?.title = venue.name
    }
    
    // MARK: UICollectionViewDelegateFlowLayout
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        guard let venue = dataSource.venue else {
            return .zero
        }
        
        return CGSize(
            width: view.bounds.width,
            height: dataSource.cellTypeAtIndexPath(indexPath).heightForCell(venue)
        )
    }
    
    // MARK: VenueDetailActionsCollectionViewCellDelegate
    func venueDetailCellDidSelectCall() {
        venueDetailPresenter.callSelected()
    }
    
    func venueDetailCellDidSelectMenu() {
        venueDetailPresenter.menuSelected()
    }
    
    // MARK: Private
    func initCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 1
        
        collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.dataSource = dataSource
        collectionView.delegate = self
        collectionView.backgroundColor = .whiteColor()
        
        view.addSubview(collectionView)
        
        collectionView.leadingAnchor.constraintEqualToAnchor(view.leadingAnchor).active = true
        collectionView.trailingAnchor.constraintEqualToAnchor(view.trailingAnchor).active = true
        collectionView.topAnchor.constraintEqualToAnchor(topLayoutGuide.bottomAnchor).active = true
        collectionView.bottomAnchor.constraintEqualToAnchor(bottomLayoutGuide.topAnchor).active = true
        
        dataSource.registerCells(collectionView)
    }
}

