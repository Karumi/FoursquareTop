
import Foundation

protocol VenueDetailUI : class, BaseUI {
    func showVenue(venue: VenueViewModel)
    func showMapProviders(providers: [MapProvider])
}