
import Foundation

protocol VenueNavigator {
    func goTo(venueDetail venue: VenueViewModel)
}

extension RootNavigator : VenueNavigator {
    func goTo(venueDetail venue: VenueViewModel) {
        let vc = serviceLocator.venue.getVenueDetailViewController(venue)
        currentNavigationController?.pushViewController(vc, animated: true)
    }
}