
import Foundation
import MapKit
import Result

protocol GetUserLocationUseCase {
    func execute(callback: Result<CLLocation, LocationError> -> ())
    func isLocationPotentiallyGood() -> Bool
}

struct GetUserLocation : GetUserLocationUseCase {
    
    private let metersToConsiderNewLocation: CLLocationDistance = 1000
    private let gps: GPS
    private let repository: LocationRepositoryProtocol
    
    init(gps: GPS, repository: LocationRepositoryProtocol) {
        self.gps = gps
        self.repository = repository
    }
    
    func execute(callback: Result<CLLocation, LocationError> -> ()) {
        let savedLocation = repository.get()
        
        gps.getUserPosition(withAccuracy: .Block, timeout: 10) { result in
            if let recentlyFetchedLocation = result.value {
                
                if let savedLocation = savedLocation {
                    if self.isNewLocationDifferentEnoughFromTheNewOne(savedLocation: savedLocation, recentlyFetchedLocation: recentlyFetchedLocation) {
                        self.repository.save(recentlyFetchedLocation)
                        callback(Result(recentlyFetchedLocation))
                    } else {
                        callback(Result(savedLocation))
                    }
                } else {
                    self.repository.save(recentlyFetchedLocation)
                    callback(Result(recentlyFetchedLocation))
                }
                
            } else {
                callback(result)
            }
        }
    }
    
    func isLocationPotentiallyGood() -> Bool {
        return repository.isTTLValid()
    }
    
    private func isNewLocationDifferentEnoughFromTheNewOne(savedLocation savedLocation: CLLocation, recentlyFetchedLocation: CLLocation) -> Bool {
        return recentlyFetchedLocation.distanceFromLocation(savedLocation) >= metersToConsiderNewLocation
    }
}