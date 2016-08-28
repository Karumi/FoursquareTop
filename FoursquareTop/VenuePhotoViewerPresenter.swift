
import Foundation

class VenuePhotoViewerPresenter {
    
    private let navigator: VenueDetailNavigator
    
    init(navigator: VenueDetailNavigator) {
        self.navigator = navigator
    }
    
    func closeSelected() {
        navigator.closePhotoViewer()
    }
}