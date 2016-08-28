
import UIKit
import NYTPhotoViewer

class VenueDetailViewController : FTViewController, VenueDetailUI, VenueDetailActionsCollectionViewCellDelegate, VenueDetailInformationDelegate, VenueDetailGalleryViewControllerDelegate, VenueDetailGalleryCollectionViewCellDelegate {
    
    var pageIndex = 0
    var venueDetailPresenter: VenueDetailPresenter!
    override var presenter: Presenter? {
        return venueDetailPresenter
    }
    
    override var contentView: UIView {
        return collectionView
    }
    
    var galleryCell: VenueDetailGalleryCollectionViewCell? {
        return dataSource.galleryCell
    }
    
    var informationCell: VenueDetailInformationCollectionViewCell? {
        return dataSource.informationCell
    }
    
    private var collectionView: UICollectionView!
    private lazy var dataSource: VenueDetailCollectionViewDataSource = {
        return VenueDetailCollectionViewDataSource(
            providers: [
                VenueDetailGalleryCellProvider(delegate: self),
                VenueDetailActionsCellProvider(delegate: self),
                VenueDetailInformationCellProvider(delegate: self),
                VenueDetailTipCellProvider(),
            ]
        )
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        automaticallyAdjustsScrollViewInsets = false
        
        initCollectionView()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
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
            title: tr(.VenueDetailMapPickerTitle),
            message: tr(.VenueDetailMapPickerMessage),
            preferredStyle: .ActionSheet
        )
        
        let actions = providers.map { provider in
            return UIAlertAction(
                title: provider.rawValue,
                style: .Default) { _ in
                    self.venueDetailPresenter.mapProviderSelected(provider)
            }
        }
        
        let cancelAction = UIAlertAction(title: tr(.Cancel), style: .Cancel, handler: nil)
        
        let allActions = actions + [cancelAction]
        allActions.forEach(alert.addAction)
        
        presentViewController(alert, animated: true, completion: nil)
    }
    
    func showMap(image: UIImage) {
        informationCell?.showMap(image)
    }
    
    // MARK: VenueDetailGalleryCollectionViewCellDelegate
    func venueDetailGalleryCellDidSelectImage(index: Int, venue: VenueViewModel) {
        venueDetailPresenter.galleryPhotoSelected(venue, selectedIndex: index, delegate: self)
    }
    
    func venueDetailGalleryCellDidMoveToImageIndex(index: Int, venue: VenueViewModel) {
        dataSource.photoIndex = index
    }
    
    // MARK: VenueDetailGalleryViewControllerDelegate
    func photosViewController(photosViewController: NYTPhotosViewController, referenceViewForPhoto photo: NYTPhoto) -> UIView? {
        return galleryCell
    }
    
    func photosViewController(photosViewController: NYTPhotosViewController, didNavigateToPhoto photo: NYTPhoto, atIndex photoIndex: UInt) {
        let index = Int(photoIndex)
        dataSource.photoIndex = index
        galleryCell?.setImageIndex(index)
    }
    
    func photosViewController(photosViewController: NYTPhotosViewController, titleForPhoto photo: NYTPhoto, atIndex photoIndex: UInt, totalPhotoCount: UInt) -> String? {
        return String.localizedStringWithFormat(
            tr(.VenueDetailPhotoGalleryTitle(Int(photoIndex + 1), Int(totalPhotoCount)))
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
        collectionView.delegate = dataSource
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
                    image: UIImage(asset: .Ic_phone),
                    style: .Plain,
                    target: self,
                    action: #selector(callSelected)
                )
            )
            
            if let url = venue.foursquareURL where UIApplication.sharedApplication().canOpenURL(url) {
                buttons.append(
                    UIBarButtonItem(
                        image: UIImage(asset: .Ic_foursquare),
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

