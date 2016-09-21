
import UIKit

protocol VenueDetailViewControllerProvider {
    func getVenueDetailViewControllerAtIndex(venues: [VenueViewModel], index: Int) -> UIViewController
}

struct DefaultVenueDetailViewControllerProvider: VenueDetailViewControllerProvider {
    
    let compositionRoot: VenueCompositionRoot
    
    func getVenueDetailViewControllerAtIndex(venues: [VenueViewModel], index: Int) -> UIViewController {
        return compositionRoot.getVenueDetailViewController(venues[index].foursquareID, forIndex: index)
    }
}
