
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
        
        navigationController?.navigationBar.topItem?.title = NSLocalizedString("BestPlacesAround.Title", comment: "Best places to eat around you screen title")
    }
    
    // MARK: BestVenuesAroundYouUI
    func showVenueList(venueList: VenueListViewModel) {
        dataSource.venueList = venueList
        collectionView.reloadData()
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
