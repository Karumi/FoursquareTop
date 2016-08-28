
import Foundation
@testable import FoursquareTop

class StubEnvironment : EnvironmentProtocol {
    
    var foursquareInstalled: Bool = false
    var mapProviders: [MapProvider] = [.Apple]
    
    func isFoursquareInstalled() -> Bool {
        return foursquareInstalled
    }
    
    func getAvailableMapProviders() -> [MapProvider] {
        return mapProviders
    }
}