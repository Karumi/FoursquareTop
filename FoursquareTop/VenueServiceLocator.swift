
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
            getBestPlacesAroundYouUseCase: GetBestPlacesAroundYou(
                dataSource: getVenueDataSource()
            ),
            getUserLocationUseCase: GetUserLocation(
                gps: getGPS(),
                repository: getVenueDataSource()
            ),
            navigator: getVenueListNavigator()
        )
        
        return vc
    }
    
    // MARK: DataSource
    
    private let venueDataSource = VenueDataSource()
    func getVenueDataSource() -> VenueDataSource {
        return venueDataSource
    }
    
    // MARK: Repository
    
    private let locationRepository = LocationRepository()
    func getVenueDataSource() -> LocationRepositoryProtocol {
        return locationRepository
    }
    
    // MARK: GPS
    func getGPS() -> GPS {
        return IntuLocationManagerGPS()
    }
    
    // MARK: Navigator
    
    func getVenueListNavigator() -> VenueListNavigator {
        return navigator
    }
    
    func getVenueDetailNavigator() -> VenueDetailNavigator {
        return navigator
    }
}