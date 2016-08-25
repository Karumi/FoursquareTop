
import UIKit

class VenueServiceLocator {
    
    var serviceLocator: RootServiceLocator!
    var navigator: RootNavigator!
    
    func getVenueDetailViewController(venue: VenueViewModel) -> UIViewController {
        let vc = VenueDetailViewController()
        vc.venueDetailPresenter = VenueDetailPresenter(
            ui: vc,
            useCase: GetVenueDetails(
                dataSource: getVenueDataSource()
            ),
            venue: venue,
            navigator: getVenueDetailNavigator()
        )
        
        return vc
    }
    
    func getBestVenuesAroundViewController() -> UIViewController {
        let vc = BestVenuesAroundYouViewController()
        vc.venuesAroundYouPresenter = BestVenuesAroundYouPresenter(
            ui: vc,
            useCase: GetBestPlacesAroundYou(
                dataSource: getVenueDataSource()
            ),
            navigator: getVenueListNavigator()
        )
        
        return vc
    }
    
    private let venueDataSource = VenueDataSource()
    func getVenueDataSource() -> VenueDataSource {
        return venueDataSource
    }
    
    func getVenueListNavigator() -> VenueListNavigator {
        return navigator
    }
    
    func getVenueDetailNavigator() -> VenueDetailNavigator {
        return navigator
    }
}