
import Foundation
import MapKit

class VenueDetailPresenter : Presenter {
    
    private let partialVenue: VenueViewModel
    private weak var ui: VenueDetailUI?
    private let useCase: GetVenueDetailsUseCase
    private let navigator: VenueDetailNavigator
    private let environment: EnvironmentProtocol
    private var venue: VenueViewModel?
    
    init(ui: VenueDetailUI, useCase: GetVenueDetailsUseCase, venue: VenueViewModel, navigator: VenueDetailNavigator, environment: EnvironmentProtocol) {
        self.ui = ui
        self.useCase = useCase
        self.partialVenue = venue
        self.navigator = navigator
        self.environment = environment
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
    
    func openInFoursquareSelected() {
        guard let venue = venue else {
            return
        }
        
        navigator.openInFoursquare(venueDetail: venue)
    }
    
    func mapSelected() {
        let availableProviders = environment.getAvailableMapProviders()
        
        guard let venue = venue where availableProviders.count > 0 else {
            return
        }
        
        if availableProviders.count > 1 {
            ui?.showMapProviders(availableProviders)
        } else {
            navigator.openInMaps(venueDetail: venue, usingProvider: availableProviders.first!)
        }
    }
    
    func mapProviderSelected(provider: MapProvider) {
        guard let venue = venue else {
            return
        }
        
        navigator.openInMaps(venueDetail: venue, usingProvider: provider)
    }
}