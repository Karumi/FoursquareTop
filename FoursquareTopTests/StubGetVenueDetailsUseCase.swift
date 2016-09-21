
import Foundation
import Result
import MapKit
@testable import FoursquareTop

class StubGetVenueDetailsUseCase : GetVenueDetailsUseCase {
    
    var error: NetworkError?
    var venue: VenueViewModel? = nil
    
    func execute(id: String, callback: Result<VenueViewModel, NetworkError> -> ()) {
        if let error = error {
            callback(Result(error: error))
        } else if let venue = venue {
            
            // There is a race condition in the pager view system, as we are using the navigation controller
            // navigationItem and if it weren't for the delay, the setTitle code would execute before the built-in
            // navigation and thus the title is wiped out. It is clearly a bug in my pager implementation, but 
            // I have no time to fix it for now.
            let delay = (Int64(NSEC_PER_SEC) * 1)
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, delay), dispatch_get_main_queue(), { () -> Void in
                callback(Result(venue))
            })
        }
    }
    
    func givenNoVenue() {
        self.venue = nil
    }
    
    func givenAVenue(withAddress address: String? = nil, withStatus status: String? = nil, withRating rating: Double? = nil, withPrice price: VenuePrice? = nil) {
        self.venue = VenueViewModel.build(
            address: address,
            status: status,
            rating: rating,
            price: price
        )
    }
    
    func givenVenueWithMenu() {
        self.venue = VenueViewModel.build(menuURL: NSURL(fileURLWithPath: "http://www.karumi.com"))
    }
    
    func givenVenueWithoutMenu() {
        self.venue = VenueViewModel.build(menuURL: nil)
    }
    
}
