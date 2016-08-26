
import UIKit
import SDWebImage

let VenueDetailGalleryCollectionViewCellReusdeIdentifier = "VenueDetailGalleryCollectionViewCellReusdeIdentifier"

protocol VenueDetailGalleryCollectionViewCellDelegate : class {
    func venueDetailGalleryCellDidSelectImage(index: Int, venue: VenueViewModel)
    func venueDetailGalleryCellDidMoveToImageIndex(index: Int, venue: VenueViewModel)
}

protocol DetailCell {
    func configure(withVenue venue: VenueViewModel)
}

class VenueDetailGalleryCollectionViewCell : UICollectionViewCell, UIScrollViewDelegate, DetailCell {
    
    @IBOutlet weak var noPhotosImage: UIImageView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    private let galleryWidth = UIScreen.mainScreen().bounds.width
    private let galleryHeight: CGFloat = 200
    
    var scrollViewImagesHeightLayoutConstraints: [NSLayoutConstraint] = []
    weak var delegate: VenueDetailGalleryCollectionViewCellDelegate?
    var venue: VenueViewModel?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        scrollView.delegate = self
        scrollView.addGestureRecognizer(
            UITapGestureRecognizer(
                target: self, action: #selector(scrollViewTapped(_:))
            )
        )
        pageControl.pageIndicatorTintColor = .whiteColor()
        pageControl.currentPageIndicatorTintColor = .ftopBlue
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        scrollView.subviews.forEach { $0.removeFromSuperview() }
    }
    
    func scrollViewTapped(sender: AnyObject) {
        onScrollViewTapped()
    }
    
    func configure(withVenue venue: VenueViewModel) {
        self.venue = venue
        renderScrollView(venue)
        clipsToBounds = venue.photos.count == 0
    }
    
    func renderScrollView(venue: VenueViewModel) {
        
        if venue.photos.count > 0 {
            scrollView.hidden = false
            noPhotosImage.hidden = true
            
            pageControl.hidden = venue.photos.count == 1
            pageControl.numberOfPages = venue.photos.count
            
            var previousImageView: UIImageView?
            for (index, photo) in venue.photos.enumerate() {
                let imageView = UIImageView()
                imageView.translatesAutoresizingMaskIntoConstraints = false
                imageView.clipsToBounds = true
                imageView.contentMode = .ScaleAspectFill
                scrollView.addSubview(imageView)
                imageView.sd_setImageWithURL(
                    photo.url,
                    placeholderImage: UIImage(named: "image-placeholder")
                )
                
                imageView.topAnchor.constraintEqualToAnchor(scrollView.topAnchor).active = true
                let bottomAnchor = imageView.bottomAnchor.constraintEqualToAnchor(scrollView.bottomAnchor)
                bottomAnchor.priority = 900
                bottomAnchor.active = true
                
                let heightConstraint = imageView.heightAnchor.constraintEqualToConstant(galleryHeight)
                scrollViewImagesHeightLayoutConstraints.append(heightConstraint)
                heightConstraint.active = true
                
                imageView.widthAnchor.constraintEqualToConstant(galleryWidth).active = true
                
                if let previousImageView = previousImageView {
                    imageView.leadingAnchor.constraintEqualToAnchor(previousImageView.trailingAnchor).active = true
                } else {
                    imageView.leadingAnchor.constraintEqualToAnchor(scrollView.leadingAnchor).active = true
                }
                
                if index == venue.photos.count - 1 {
                    imageView.trailingAnchor.constraintEqualToAnchor(scrollView.trailingAnchor).active = true
                }
                
                previousImageView = imageView
            }
            
        } else {
            pageControl.hidden = true
            scrollView.hidden = true
            noPhotosImage.hidden = false
        }
        
        scrollView.scrollEnabled = venue.photos.count > 1
    }
    
    func onScrollViewTapped() {
        guard let venue = venue else {
            return
        }
        
        delegate?.venueDetailGalleryCellDidSelectImage(
            pageControl.currentPage,
            venue: venue
        )
    }
    
    func setImageIndex(index: Int) {
        pageControl.currentPage = index
        scrollView.scrollRectToVisible(
            CGRect(x: galleryWidth * CGFloat(index), y: 0, width: galleryWidth, height: 10),
            animated: false
        )
    }
    
    func onScrollViewDidScroll(scrollView: UIScrollView) {
        guard let venue = venue else {
            return
        }
        
        let width = galleryWidth
        pageControl.currentPage = Int(floor((scrollView.contentOffset.x - width / 2) / width)) + 1
        
        delegate?.venueDetailGalleryCellDidMoveToImageIndex(
            pageControl.currentPage,
            venue: venue
        )
    }
    
    // MARK: UIScrollViewDelegate
    func scrollViewDidScroll(scrollView: UIScrollView) {
        onScrollViewDidScroll(scrollView)
    }
}
