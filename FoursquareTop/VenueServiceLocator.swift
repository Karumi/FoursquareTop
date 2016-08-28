
import UIKit

class VenueServiceLocator {
    
    var serviceLocator: RootServiceLocator!
    var navigator: RootNavigator!
    
    func getVenueDetailPageViewController(venues: [VenueViewModel], initialIndex: Int) -> UIViewController {
        let provider = DefaultVenueDetailViewControllerProvider(serviceLocator: self)
        let vc = VenueDetailPageViewController()
        vc.dataSource = VenueDetailPageViewControllerDataSource(
            venueDetailViewControllerProvider: provider,
            venues: venues,
            initialIndex: initialIndex,
            getVenueDetailUseCase: getVenueDetailsUseCase()
        )
        vc.initialIndex = initialIndex
        
        return vc
    }
    
    func getVenueDetailViewController(venue: VenueViewModel, forIndex index: Int) -> UIViewController {
        let vc = VenueDetailViewController()
        vc.pageIndex = index
        vc.venueDetailPresenter = VenueDetailPresenter(
            ui: vc,
            useCase: getVenueDetailsUseCase(),
            venue: venue,
            navigator: getVenueDetailNavigator(),
            environment: getEnvironment(),
            snapshotGenerator: getMapSnapshotGenerator()
        )
        
        return vc
    }
    
    func getBestVenuesAroundViewController() -> UIViewController {
        let vc = BestVenuesAroundYouViewController()
        vc.venuesAroundYouPresenter = BestVenuesAroundYouPresenter(
            ui: vc,
            getBestPlacesAroundYouUseCase: getGetBestPlacesAroundYouUseCase(),
            getUserLocationUseCase: getGetUserLocationUseCase(),
            navigator: getVenueListNavigator()
        )
        
        return vc
    }
    
    func getPhotoViewerViewController(venue: VenueViewModel, initialIndex: Int, delegate: VenueDetailGalleryViewControllerDelegate) -> UIViewController {
        let vc = VenuePhotoViewerViewController(
            photos: venue.photos,
            initialPhoto: venue.photos[initialIndex],
            delegate: delegate
        )
        
        vc.presenter = VenuePhotoViewerPresenter(navigator: getVenueDetailNavigator())
        
        return vc
    }
    
    // MARK: Other Collaborators
    
    func getEnvironment() -> EnvironmentProtocol {
        return Environment()
    }
    
    func getMapSnapshotGenerator() -> MapSnapshotGeneratorProtocol {
        return MapSnapshotGenerator()
    }
    
    // MARK: Use Case
    
    func getGetUserLocationUseCase() -> GetUserLocationUseCase {
        return GetUserLocation(
            gps: getGPS(),
            repository: getVenueDataSource()
        )
    }
    
    func getGetBestPlacesAroundYouUseCase() -> GetBestPlacesAroundYouUseCase {
        return GetBestPlacesAroundYou(
            dataSource: getVenueDataSource()
        )
    }
    
    func getVenueDetailsUseCase() -> GetVenueDetailsUseCase {
        return GetVenueDetails(
            dataSource: getVenueDataSource()
        )
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