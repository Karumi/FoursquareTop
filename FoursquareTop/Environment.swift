
import UIKit

protocol EnvironmentProtocol {
    func isFoursquareInstalled() -> Bool
    func getAvailableMapProviders() -> [MapProvider]
}

struct Environment : EnvironmentProtocol {
    func isFoursquareInstalled() -> Bool {
        guard let url = NSURL(string: "foursquare://venues/12345") else {
            return false
        }
        
        return UIApplication.sharedApplication().canOpenURL(url)
    }
    
    func getAvailableMapProviders() -> [MapProvider] {
        return MapProvider.all.filter(isMapProviderSupported)
    }
    
    private func isMapProviderSupported(provider: MapProvider) -> Bool {
        switch provider {
        case .Apple:
            return true
        case .Google:
            guard let url = NSURL(string: "comgooglemaps://?center=40.765819,-73.975866") else {
                return false
            }
            
            return UIApplication.sharedApplication().canOpenURL(url)
        }
    }
}