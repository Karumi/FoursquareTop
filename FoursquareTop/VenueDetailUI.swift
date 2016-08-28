
import UIKit

protocol VenueDetailUI : class, BaseUI {
    func showVenue(venue: VenueViewModel)
    func showMap(image: UIImage)
    func showMapProviders(providers: [MapProvider])
}