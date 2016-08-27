
import Foundation
import MapKit

class BestVenuesAroundYouPresenter : Presenter {
    
    private weak var ui: BestVenuesAroundYouUI?
    private let navigator: VenueListNavigator
    private let getBestPlacesAroundYouUseCase: GetBestPlacesAroundYouUseCase
    private let getUserLocationUseCase: GetUserLocationUseCase
    private var venues: [VenueViewModel] = []
    
    init(ui: BestVenuesAroundYouUI, getBestPlacesAroundYouUseCase: GetBestPlacesAroundYouUseCase, getUserLocationUseCase: GetUserLocationUseCase, navigator: VenueListNavigator) {
        self.ui = ui
        self.getBestPlacesAroundYouUseCase = getBestPlacesAroundYouUseCase
        self.getUserLocationUseCase = getUserLocationUseCase
        self.navigator = navigator
    }
    
    func viewDidAppear() {
        loadBestVenuesAroundCurrentUser()
    }
    
    func retry() {
        loadBestVenuesAroundCurrentUser()
    }
    
    func openSettingsSelected() {
        navigator.goToSettings()
    }
    
    private func loadBestVenuesAroundCurrentUser() {
        self.ui?.loading = !getUserLocationUseCase.isLocationPotentiallyGood()
        
        getUserLocationUseCase.execute { locationResult in
            self.ui?.loading = false
            if let location = locationResult.value {
                self.getBestPlacesAroundYouUseCase.execute(location) { result in
                    if let venueList = result.value {
                        self.venues = venueList.venues
                        self.ui?.showVenueList(venueList)
                    } else {
                        self.ui?.showError(message: "Could not fetch the venues, please tap anywhere to retry")
                    }
                }
            } else {
                switch locationResult.error! {
                case .CanNotFetch:
                    self.ui?.showError(message: "Could not fetch your location, please tap anywhere to retry")
                case .NoGPSAccess:
                    self.ui?.showError(message: "Can not access to your GPS")
                    self.ui?.showNoGPSAccessError()
                }
            }
        }
    }
    
    func venueSelected(venue: VenueViewModel) {
        navigator.goTo(venueDetail: venue, ofList: venues)
    }
}