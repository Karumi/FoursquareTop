
import Foundation
import SafariServices

protocol VenueDetailNavigator {
    func dismissVenueDetail()
    func goToMenu(venueDetail venue: VenueViewModel)
    func call(venueDetail venue: VenueViewModel)
    func openInFoursquare(venueDetail venue: VenueViewModel)
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

    private func goTo(url url: NSURL) {
        let vc = SFSafariViewController(
            URL: url
        )
        
        currentNavigationController?.presentViewController(vc, animated: true, completion: nil)
    }
}