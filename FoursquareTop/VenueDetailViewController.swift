
import UIKit

class VenueDetailViewController : FTViewController, VenueDetailUI, UICollectionViewDelegateFlowLayout, VenueDetailActionsCollectionViewCellDelegate, VenueDetailInformationDelegate {
    
    var pageIndex = 0
    var venueDetailPresenter: VenueDetailPresenter!
    override var presenter: Presenter? {
        return venueDetailPresenter
    }
    
    private var cellHeightCalculator: VenueDetailCollectionViewCellHeightCalculator!
    private var collectionView: UICollectionView!
    private lazy var dataSource: VenueDetailCollectionViewDataSource = {
        return VenueDetailCollectionViewDataSource(detailActionsCellDelegate: self, detailInformationDelegate: self)
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        automaticallyAdjustsScrollViewInsets = false
        
        initCollectionView()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        cellHeightCalculator = VenueDetailCollectionViewCellHeightCalculator(availableWidth: view.bounds.width)
        
        if let venue = dataSource.venue {
            setScreenTitle(venue)
        }
    }
    
    func callSelected() {
        venueDetailPresenter.callSelected()
    }
    
    func openInFoursquareSelected() {
        venueDetailPresenter.openInFoursquareSelected()
    }
    
    // MARK: VenueDetailUI
    func showVenue(venue: VenueViewModel) {
        dataSource.venue = venue
        collectionView.reloadData()
        setScreenTitle(venue)
    }
    
    func showMapProviders(providers: [MapProvider]) {
        
        let alert = UIAlertController(
            title: NSLocalizedString("VenueDetail.MapPicker.Title", comment: "Title of the map picker in an alert"),
            message: NSLocalizedString("VenueDetail.MapPicker.Message", comment: "Message of the map picker in an alert"),
            preferredStyle: .ActionSheet
        )
        
        let actions = providers.map { provider in
            return UIAlertAction(
                title: provider.rawValue,
                style: .Default) { _ in
                    self.venueDetailPresenter.mapProviderSelected(provider)
            }
        }
        
        let cancelAction = UIAlertAction(title: NSLocalizedString("VenuesList.NoGPSAccess.Cancel", comment: "Cancel button"), style: .Cancel, handler: nil)
        
        let allActions = actions + [cancelAction]
        allActions.forEach(alert.addAction)
        
        presentViewController(alert, animated: true, completion: nil)
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
    func venueDetailCellDidSelectMenu() {
        venueDetailPresenter.menuSelected()
    }
    
    // MARK: VenueDetailInformationDelegate
    func venueDetailInformationDidTapMap() {
        venueDetailPresenter.mapSelected()
    }
    
    // MARK: Private
    private func initCollectionView() {
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
    
    // MARK : Private 
    
    private func setScreenTitle(venue: VenueViewModel) {
        let titleView = VenueDetailTitleView()
        titleView.configure(withVenue: venue)
        let size = titleView.intrinsicContentSize()
        titleView.frame = CGRect(origin: .zero, size: size)
        
        navigationController?.navigationBar.topItem?.titleView = titleView
        
        if let _ = venue.phone {
            var buttons: [UIBarButtonItem] = []
            
            buttons.append(
                UIBarButtonItem(
                    image: UIImage(named: "ic_phone"),
                    style: .Plain,
                    target: self,
                    action: #selector(callSelected)
                )
            )
            
            if let url = venue.foursquareURL where UIApplication.sharedApplication().canOpenURL(url) {
                buttons.append(
                    UIBarButtonItem(
                        image: UIImage(named: "ic_foursquare"),
                        style: .Plain,
                        target: self,
                        action: #selector(openInFoursquareSelected)
                    )
                )
            }
            
            navigationController?.navigationBar.topItem?.rightBarButtonItems = buttons
        }
    }
}

