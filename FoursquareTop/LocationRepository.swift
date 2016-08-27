
import Foundation
import MapKit

protocol LocationRepositoryProtocol {
    func save(location: CLLocation)
    func get() -> CLLocation?
    func isTTLValid() -> Bool
}

class LocationRepository : LocationRepositoryProtocol {
    
    private var location: CLLocation?
    private var saveTime: NSDate?
    private let ttl: NSTimeInterval = 60 * 10
    
    func save(location: CLLocation) {
        self.location = location
        self.saveTime = NSDate()
    }
    
    func get() -> CLLocation? {
        guard isValid() else {
            return nil
        }
        
        return location
    }
    
    func isTTLValid() -> Bool {
        guard let saveTime = saveTime else {
            return false
        }
        
        return -saveTime.timeIntervalSinceNow < ttl
    }
    
    private func isValid() -> Bool {
        guard let _ = location else {
            return false
        }
        
        return isTTLValid()
    }
}