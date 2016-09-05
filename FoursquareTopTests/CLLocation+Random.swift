
import Foundation
import MapKit

extension CLLocation {
    
    static func random() -> CLLocation {
        return CLLocation(
            latitude: Double.random(40.0001, max: 41),
            longitude: Double.random(-0.0001, max: 1)
        )
    }
    
}
