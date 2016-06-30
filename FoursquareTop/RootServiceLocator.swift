
import UIKit

class RootServiceLocator : NSObject {
    
    let venue: VenueServiceLocator

    private(set) static var instance: RootServiceLocator = RootServiceLocator.Builder().build()
    
    static func override(rootServiceLocator: RootServiceLocator) {
        RootServiceLocator.instance = rootServiceLocator
    }
    
    private convenience override init() {
        self.init(
            venue: VenueServiceLocator()
        )
    }
    
    private init(
        venue: VenueServiceLocator
    ) {
        self.venue = venue
    }
    
    func getInitialViewController() -> UINavigationController {
        let vc = venue.getBestVenuesAroundViewController()
        return UINavigationController(rootViewController: vc)
    }
    
    class Builder {
        var venue = VenueServiceLocator()
        
        init() {
            
        }
        
        init(serviceLocator: RootServiceLocator) {
            venue = serviceLocator.venue
        }

        func with(venueServiceLocator venue: VenueServiceLocator) -> Builder {
            self.venue = venue
            return self
        }

        func build() -> RootServiceLocator {
            let rootServiceLocator = RootServiceLocator(
                venue: venue
            )
            
            venue.serviceLocator = rootServiceLocator
            
            return rootServiceLocator
        }
    }
}