
import UIKit

protocol VenueListNavigator {
    func goTo(venueDetail venue: VenueViewModel)
    func goToSettings()
}

extension RootNavigator : VenueListNavigator {
    func goTo(venueDetail venue: VenueViewModel) {
        let vc = serviceLocator.venue.getVenueDetailViewController(venue)
        currentNavigationController?.pushViewController(vc, animated: true)
    }
    
    func goToSettings() {
        guard let appSettings = NSURL(string: UIApplicationOpenSettingsURLString) else {
            return
        }
        
        UIApplication.sharedApplication().openURL(appSettings)
    }
}