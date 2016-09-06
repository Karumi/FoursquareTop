
import Foundation
import Result
import MapKit
@testable import FoursquareTop

class StubGetUserLocationUseCase : GetUserLocationUseCase {
    
    var error: LocationError?
    var location: CLLocation? = CLLocation(latitude: 40.4168533, longitude: -3.7073171)
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
    
    func givenWeAreFetchingUsersLocation() {
        location = nil
    }
    
    func givenThereWillBeAnErrorFetchingUsersLocation() {
        error = .CanNotFetch
    }
    
    func givenWeCanNotAccessTheGPS() {
        error = .NoGPSAccess
    }
}