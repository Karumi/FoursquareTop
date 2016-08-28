
import UIKit

class BestVenuesAroundYouViewController : FTViewController, BestVenuesAroundYouUI, UICollectionViewDelegateFlowLayout {
    
    var venuesAroundYouPresenter: BestVenuesAroundYouPresenter!
    override var presenter: Presenter? {
        return venuesAroundYouPresenter
    }
    
    private var collectionView: UICollectionView!
    private var dataSource = BestVenuesAroundYouCollectionViewDataSource()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        automaticallyAdjustsScrollViewInsets = false
        
        initCollectionView()
        
        navigationItem.title = tr(.BestPlacesAroundTitle)
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .Plain, target: nil, action: nil)
    }
    
    // MARK: BestVenuesAroundYouUI
    func showVenueList(venueList: VenueListViewModel) {
        dataSource.venueList = venueList
        collectionView.reloadData()
    }

    func showNoGPSAccessError() {
        let alert = UIAlertController(
            title: tr(.VenuesListNoGPSAccessErrorTitle),
            message: tr(.VenuesListNoGPSAccessErrorMessage),
            preferredStyle: .Alert
        )
        
        let openSettingsAction = UIAlertAction(
            title: tr(.VenuesListNoGPSAccessGoToGeneralSettings),
            style: .Default) { _ in
                
                self.venuesAroundYouPresenter.openSettingsSelected()
        }
        let cancelAction = UIAlertAction(title: tr(.Cancel), style: .Cancel, handler: nil)
        
        alert.addAction(openSettingsAction)
        alert.addAction(cancelAction)
        
        presentViewController(alert, animated: true, completion: nil)
    }
    
    // MARK: UICollectionViewDelegateFlowLayout
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        if indexPath.item == 0 {
            return CGSize(width: view.bounds.width, height: 100)
        } else {
            return CGSize(width: view.bounds.width, height: 60)
        }
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        guard let venue = dataSource.venue(atIndexPath: indexPath) else {
            return
        }
        
        venuesAroundYouPresenter.venueSelected(venue)
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
