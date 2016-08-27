
import UIKit

class VenueDetailViewController : FTViewController, VenueDetailUI, UICollectionViewDelegateFlowLayout, VenueDetailActionsCollectionViewCellDelegate {
    
    var venueDetailPresenter: VenueDetailPresenter!
    override var presenter: Presenter? {
        return venueDetailPresenter
    }
    
    private var cellHeightCalculator: VenueDetailCollectionViewCellHeightCalculator!
    private var collectionView: UICollectionView!
    private lazy var dataSource: VenueDetailCollectionViewDataSource = {
        return VenueDetailCollectionViewDataSource(detailActionsCellDelegate: self)
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        automaticallyAdjustsScrollViewInsets = false
        
        initCollectionView()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        cellHeightCalculator = VenueDetailCollectionViewCellHeightCalculator(availableWidth: view.bounds.width)
    }
    
    // MARK: VenueDetailUI
    func showVenue(venue: VenueViewModel) {
        dataSource.venue = venue
        collectionView.reloadData()
        
        let titleView = VenueDetailTitleView()
        titleView.configure(withVenue: venue)
        let size = titleView.intrinsicContentSize()
        titleView.frame = CGRect(origin: .zero, size: size)
        
        navigationController?.navigationBar.topItem?.titleView = titleView
    }
    
    // MARK: UICollectionViewDelegateFlowLayout
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        guard let venue = dataSource.venue else {
            return .zero
        }
        
        return CGSize(
            width: view.bounds.width,
            height: cellHeightCalculator.heightForCell(
                forType: dataSource.cellTypeAtIndexPath(indexPath),
                venue: venue
            )
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
        layout.minimumLineSpacing = 0
        
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

