
import Foundation
@testable import FoursquareTop

class StubVenueDetailNavigator : VenueDetailNavigator {
    
    var venue: VenueViewModel? = nil
    var photoViewerSelectedIndex: Int = 0
    var mapProvider: MapProvider? = nil
    
    var didDismissVenueDetail = false
    var didGoToMenu = false
    var didGoToPhotoViewer = false
    var didClosePhotoViewer = false
    var didCall = false
    var didOpenInFoursquare = false
    var didOpenInMaps = false
    
    func dismissVenueDetail() {
        didDismissVenueDetail = true
    }
    
    func goToMenu(venueDetail venue: VenueViewModel) {
        didGoToMenu = true
        self.venue = venue
    }
    
    func goToPhotoViewer(venueDetail venue: VenueViewModel, selectedIndex: Int, delegate: VenueDetailGalleryViewControllerDelegate) {
        self.venue = venue
        photoViewerSelectedIndex = selectedIndex
        didGoToPhotoViewer = true
    }
    
    func closePhotoViewer() {
        didClosePhotoViewer = true
    }
    
    func call(venueDetail venue: VenueViewModel) {
        didCall = true
        self.venue = venue
    }
    
    func openInFoursquare(venueDetail venue: VenueViewModel) {
        didOpenInFoursquare = true
        self.venue = venue
    }
    
    func openInMaps(venueDetail venue: VenueViewModel, usingProvider: MapProvider) {
        didOpenInMaps = true
        self.venue = venue
        self.mapProvider = usingProvider
    }
}