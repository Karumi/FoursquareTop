
import Foundation

protocol VenueListNavigator {
    func goTo(venueDetail venue: VenueViewModel)
}

extension RootNavigator : VenueListNavigator {
    func goTo(venueDetail venue: VenueViewModel) {
        let vc = serviceLocator.venue.getVenueDetailViewController(venue)
        currentNavigationController?.pushViewController(vc, animated: true)
    }
}