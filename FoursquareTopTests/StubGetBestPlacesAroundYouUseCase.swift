
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
    
    
    func givenThereWillBeAnErrorFetchingVenues() {
        error = .Generic
    }
    
    func givenThereWillBeVenues(venuesCount count: Int = 10, categoryCount: Int = 5) {
        guard count > 0 else {
            error = .EmptyResult
            return
        }
        
        error = nil
        
        venueList = VenueListViewModel.random(venueCount: count, categoryCount: categoryCount)
    }
}