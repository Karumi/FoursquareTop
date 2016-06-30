
import Foundation
import MapKit

struct VenueDetailPresenter : Presenter {
    
    private let partialVenue: VenueViewModel
    private let ui: VenueDetailUI
    private let useCase: GetVenueDetailsUseCase
    
    init(ui: VenueDetailUI, useCase: GetVenueDetailsUseCase, venue: VenueViewModel) {
        self.ui = ui
        self.useCase = useCase
        self.partialVenue = venue
    }
    
    func viewWillAppear() {
        useCase.execute(partialVenue.foursquareID) { result in
            if let venue = result.value {
                self.ui.showVenue(venue)
            }
        }
    }
}