
import UIKit

class AppCompositionRoot : NSObject {
    
    let venue: VenueCompositionRoot

    private convenience override init() {
        self.init(
            venue: VenueCompositionRoot()
        )
    }
    
    private init(
        venue: VenueCompositionRoot
    ) {
        self.venue = venue
    }
    
    func getInitialViewController() -> UINavigationController {
        let vc = venue.getBestVenuesAroundViewController()
        return UINavigationController(rootViewController: vc)
    }
    
    class Builder {
        var venue = VenueCompositionRoot()
        
        init() {
            
        }
        
        init(serviceLocator: AppCompositionRoot) {
            venue = serviceLocator.venue
        }

        func with(venueServiceLocator venue: VenueCompositionRoot) -> Builder {
            self.venue = venue
            return self
        }

        func build() -> AppCompositionRoot {
            let appCompositionRoot = AppCompositionRoot(
                venue: venue
            )
            
            venue.appCompositionRoot = appCompositionRoot
            
            return appCompositionRoot
        }
    }
}