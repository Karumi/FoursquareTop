
import Foundation
import Result
import MapKit
@testable import FoursquareTop

class StubGetBestPlacesAroundYouUseCase : GetBestPlacesAroundYouUseCase {
    
    var error: NetworkError?
    var venueList: VenueListViewModel? = nil
    
    func execute(location: CLLocation, callback: Result<VenueListViewModel, NetworkError> -> ()) {
        if let error = error {
            callback(Result(error: error))
        } else if let venueList = venueList {
            callback(Result(venueList))
        }
    }
}