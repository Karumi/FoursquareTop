
import Foundation
import Result
import MapKit
@testable import FoursquareTop

class StubGetUserLocationUseCase : GetUserLocationUseCase {
    
    var error: LocationError?
    var location: CLLocation? = nil
    var locationIsPotentiallyGood = false
    
    func execute(callback: Result<CLLocation, LocationError> -> ()) {
        if let error = error {
            callback(Result(error: error))
        } else if let location = location {
            callback(Result(location))
        }
    }
    
    func isLocationPotentiallyGood() -> Bool {
        return locationIsPotentiallyGood
    }
}