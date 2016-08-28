
import Foundation
@testable import FoursquareTop

class StubVenueListNavigator : VenueListNavigator {
    
    var didGoToVenueDetail = false
    var venueDetail: VenueViewModel? = nil
    var venueList: [VenueViewModel]? = nil
    
    var didGoToSettings = false
    
    func goTo(venueDetail venue: VenueViewModel, ofList list: [VenueViewModel]) {
        didGoToVenueDetail = true
        venueDetail = venue
        venueList = list
    }
    
    func goToSettings() {
        didGoToSettings = true
    }
    
}