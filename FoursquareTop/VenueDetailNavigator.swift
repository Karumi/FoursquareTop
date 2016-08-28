
import Foundation
import SafariServices

enum MapProvider : String {
    case Apple
    case Google
    
    static var all: [MapProvider] = [.Apple, .Google]
}

protocol VenueDetailNavigator {
    func dismissVenueDetail()
    func goToMenu(venueDetail venue: VenueViewModel)
    func call(venueDetail venue: VenueViewModel)
    func openInFoursquare(venueDetail venue: VenueViewModel)
    func openInMaps(venueDetail venue: VenueViewModel, usingProvider: MapProvider)
}

extension RootNavigator : VenueDetailNavigator {
    func goToMenu(venueDetail venue: VenueViewModel) {
        guard let url = venue.menuURL else {
            return
        }
        
        goTo(url: url)
    }
    
    func dismissVenueDetail() {
        currentNavigationController?.popViewControllerAnimated(true)
    }
    
    func call(venueDetail venue: VenueViewModel) {
        guard let phone = venue.phone, let url = NSURL(string: "tel://\(phone)") else {
            return
        }
        
        UIApplication.sharedApplication().openURL(url)
    }
    
    func openInFoursquare(venueDetail venue: VenueViewModel) {
        guard let url = venue.foursquareURL else {
            return
        }
        
        UIApplication.sharedApplication().openURL(url)
    }

    func openInMaps(venueDetail venue: VenueViewModel, usingProvider provider: MapProvider) {
        
        let lat = String(venue.location.coordinate.latitude)
        let lng = String(venue.location.coordinate.longitude)
        
        switch provider {
        case .Apple:
            if let url = NSURL(string: "http://maps.apple.com/?ll=\(lat),\(lng)") {
                UIApplication.sharedApplication().openURL(url)
            }
        case .Google:
            if let url = NSURL(string: "comgooglemaps://?center=\(lat),\(lng)") {
                UIApplication.sharedApplication().openURL(url)
            }
        }
    }
    
    private func goTo(url url: NSURL) {
        let vc = SFSafariViewController(
            URL: url
        )
        
        currentNavigationController?.presentViewController(vc, animated: true, completion: nil)
    }
}