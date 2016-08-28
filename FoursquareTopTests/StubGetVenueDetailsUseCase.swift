
import Foundation
import Result
import MapKit
@testable import FoursquareTop

class StubGetVenueDetailsUseCase : GetVenueDetailsUseCase {
    
    var error: NetworkError?
    var venue: VenueViewModel? = nil
    
    func execute(id: String, callback: Result<VenueViewModel, NetworkError> -> ()) {
        if let error = error {
            callback(Result(error: error))
        } else if let venue = venue {
            callback(Result(venue))
        }
    }
}