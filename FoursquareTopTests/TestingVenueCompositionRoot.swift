
import Foundation
@testable import FoursquareTop

class TestingVenueCompositionRoot : VenueCompositionRoot {
    
    var stubVenueListNavigator: StubVenueListNavigator?
    var stubVenueDetailNavigator: StubVenueDetailNavigator?
    var stubEnvironment = StubEnvironment()
    var stubSnapshotGenerator = StubMapSnapshotGenerator()
    
    var stubGetUserLocationUseCase = StubGetUserLocationUseCase()
    var stubGetBestPlacesAroundYouUseCase = StubGetBestPlacesAroundYouUseCase()
    var stubGetVenueDetailsUseCase = StubGetVenueDetailsUseCase()
    
    // MARK: Other Collaborators
    
    override func getEnvironment() -> EnvironmentProtocol {
        return stubEnvironment
    }
    
    override func getMapSnapshotGenerator() -> MapSnapshotGeneratorProtocol {
        return stubSnapshotGenerator
    }
    
    // MARK: Use Case
    
    override func getGetUserLocationUseCase() -> GetUserLocationUseCase {
        return stubGetUserLocationUseCase
    }
    
    override func getGetBestPlacesAroundYouUseCase() -> GetBestPlacesAroundYouUseCase {
        return stubGetBestPlacesAroundYouUseCase
    }
    
    override func getVenueDetailsUseCase() -> GetVenueDetailsUseCase {
        return stubGetVenueDetailsUseCase
    }
    
    // MARK: Navigator
    
    override func getVenueListNavigator() -> VenueListNavigator {
        return stubVenueListNavigator ?? super.getVenueListNavigator()
    }
    
    override func getVenueDetailNavigator() -> VenueDetailNavigator {
        return stubVenueDetailNavigator ?? super.getVenueDetailNavigator()
    }
    
}