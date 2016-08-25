
import Foundation
import MapKit

struct BestVenuesAroundYouPresenter : Presenter {
    
    private weak var ui: BestVenuesAroundYouUI?
    private let navigator: VenueListNavigator
    private let useCase: GetBestPlacesAroundYouUseCase
    
    init(ui: BestVenuesAroundYouUI, useCase: GetBestPlacesAroundYouUseCase, navigator: VenueListNavigator) {
        self.ui = ui
        self.useCase = useCase
        self.navigator = navigator
    }
    
    func viewWillAppear() {
        useCase.execute(CLLocation(latitude: 40.751622, longitude: -73.986789)) { result in
            if let venueList = result.value {
                self.ui?.showVenueList(venueList)
            }
        }
    }
    
    func venueSelected(venue: VenueViewModel) {
        navigator.goTo(venueDetail: venue)
    }
}