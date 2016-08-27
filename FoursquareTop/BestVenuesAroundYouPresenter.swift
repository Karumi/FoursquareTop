
import Foundation
import MapKit

struct BestVenuesAroundYouPresenter : Presenter {
    
    private weak var ui: BestVenuesAroundYouUI?
    private let navigator: VenueListNavigator
    private let getBestPlacesAroundYouUseCase: GetBestPlacesAroundYouUseCase
    private let getUserLocationUseCase: GetUserLocationUseCase
    
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
            if let location = locationResult.value {
                self.getBestPlacesAroundYouUseCase.execute(location) { result in
                    if let venueList = result.value {
                        self.ui?.showVenueList(venueList)
                    } else {
                        self.ui?.showError(message: "Could not fetch the venues, please tap anywhere to retry")
                    }
                    
                    self.ui?.loading = false
                }
            } else {
                switch locationResult.error! {
                case .CanNotFetch:
                    self.ui?.showError(message: "Could not fetch your location, please tap anywhere to retry")
                case .NoGPSAccess:
                    self.ui?.showError(message: "Can not access to your GPS")
                    self.ui?.showNoGPSAccessError()
                }
                
                self.ui?.loading = false
            }
        }
    }
    
    func venueSelected(venue: VenueViewModel) {
        navigator.goTo(venueDetail: venue)
    }
}