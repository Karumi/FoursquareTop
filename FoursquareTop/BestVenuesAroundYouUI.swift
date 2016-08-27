
import Foundation

protocol BestVenuesAroundYouUI : BaseUI {
    func showVenueList(venueList: VenueListViewModel)
    func showNoGPSAccessError()
}