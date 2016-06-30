
import Foundation
import MapKit
import Result

protocol GetBestPlacesAroundYouUseCase {
    func execute(location: CLLocation, callback: Result<VenueListViewModel, NetworkError> -> ())
}

struct GetBestPlacesAroundYou : GetBestPlacesAroundYouUseCase {
    
    private let dataSource: VenueDataSource
    
    init(dataSource: VenueDataSource) {
        self.dataSource = dataSource
    }
    
    func execute(location: CLLocation, callback: Result<VenueListViewModel, NetworkError> -> ()) {
        
        dataSource.topVenues(atLocation: location) { result in
            if let venueList = result.value {
                callback(Result(venueList))
            }
        }
    }
}