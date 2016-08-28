
import UIKit
import SDWebImage
import NYTPhotoViewer

typealias VenueDetailGalleryViewControllerDelegate = NYTPhotosViewControllerDelegate

class VenuePhotoViewerViewController: NYTPhotosViewController {
    
    var presenter: VenuePhotoViewerPresenter!
    private let photos: [VenuePhotoViewModel]
    
    override init(photos: [NYTPhoto]?, initialPhoto: NYTPhoto?, delegate: NYTPhotosViewControllerDelegate?) {
        self.photos = photos?.flatMap { $0 as? VenuePhotoViewModel } ?? []
        super.init(photos: photos, initialPhoto:initialPhoto, delegate:delegate)
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.photos = []
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        overlayView?.navigationBar.tintColor = .whiteColor()
        
        overlayView?.leftBarButtonItem = UIBarButtonItem(
            title: tr(.Close),
            style: .Plain,
            target: self,
            action: #selector(closeButtonTapped)
        )
        
        overlayView?.rightBarButtonItems = []
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        let manager = SDWebImageManager.sharedManager()
        photos.forEach {
            let photo = $0
            manager.downloadImageWithURL(
                $0.url,
                options: [],
                progress: { receivedSize, expectedSize in
                    
            }) { (image, error, cacheType, finished, imageURL) -> Void in
                photo.image = image
                self.updateImageForPhoto(photo)
            }
        }
    }
    
    func closeButtonTapped() {
        presenter.closeSelected()
    }
    
    override func supportedInterfaceOrientations() -> UIInterfaceOrientationMask {
        return .All
    }
    
    override func shouldAutorotate() -> Bool {
        return true
    }
}
