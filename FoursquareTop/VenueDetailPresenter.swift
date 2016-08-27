
import Foundation
import MapKit

class VenueDetailPresenter : Presenter {
    
    private let partialVenue: VenueViewModel
    private weak var ui: VenueDetailUI?
    private let useCase: GetVenueDetailsUseCase
    private let navigator: VenueDetailNavigator
    
    private var venue: VenueViewModel?
    
    init(ui: VenueDetailUI, useCase: GetVenueDetailsUseCase, venue: VenueViewModel, navigator: VenueDetailNavigator) {
        self.ui = ui
        self.useCase = useCase
        self.partialVenue = venue
        self.navigator = navigator
    }
    
    func viewWillAppear() {
        useCase.execute(partialVenue.foursquareID) { result in
            if let venue = result.value {
                self.venue = venue
                self.ui?.showVenue(venue)
            } else {
                self.ui?.showError(message: "Could not show this venue information, please tap anywhere to retry")
            }
        }
    }
    
    func menuSelected() {
        guard let venue = venue else {
            return
        }
        
        navigator.goToMenu(venueDetail: venue)
    }
    
    func callSelected() {
        guard let venue = venue else {
            return
        }
        
        navigator.call(venueDetail: venue)
    }
}