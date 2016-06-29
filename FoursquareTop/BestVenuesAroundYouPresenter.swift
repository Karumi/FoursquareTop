
import Foundation
import MapKit

struct BestVenuesAroundYouPresenter : Presenter {
    
    let ui: BestVenuesAroundYouUI
    let ds = VenueDataSource()
    
    init(ui: BestVenuesAroundYouUI) {
        self.ui = ui
    }
    
    func viewWillAppear() {
        ds.topVenues(atLocation: CLLocation(latitude: 40.751622, longitude: -73.986789)) { result in
            if let venueList = result.value {
                self.ui.showVenueList(venueList)
            }
        }
    }
    
}