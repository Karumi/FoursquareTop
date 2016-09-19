
import UIKit

protocol VenueListNavigator {
    func goTo(venueDetail venue: VenueViewModel, ofList list: [VenueViewModel])
    func goToSettings()
}

extension RootNavigator : VenueListNavigator {
    func goTo(venueDetail venue: VenueViewModel, ofList list: [VenueViewModel]) {
        let index = list.indexOf { $0.foursquareID == venue.foursquareID }
        
        let vc = appCompositionRoot.venue.getVenueDetailPageViewController(
            list,
            initialIndex: index!
        )
        
        currentNavigationController?.pushViewController(vc, animated: true)
    }
    
    func goToSettings() {
        guard let appSettings = NSURL(string: UIApplicationOpenSettingsURLString) else {
            return
        }
        
        UIApplication.sharedApplication().openURL(appSettings)
    }
}