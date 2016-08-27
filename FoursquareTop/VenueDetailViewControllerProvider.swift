
import UIKit

protocol VenueDetailViewControllerProvider {
    func getVenueDetailViewControllerAtIndex(venues: [VenueViewModel], index: Int) -> UIViewController
}

struct DefaultVenueDetailViewControllerProvider: VenueDetailViewControllerProvider {
    
    let serviceLocator: VenueServiceLocator
    
    func getVenueDetailViewControllerAtIndex(venues: [VenueViewModel], index: Int) -> UIViewController {
        return serviceLocator.getVenueDetailViewController(venues[index], forIndex: index)
    }
}