
import Foundation
import MapKit

class BestVenuesAroundYouPresenter : Presenter {
    
    private weak var ui: BestVenuesAroundYouUI?
    private let navigator: VenueListNavigator
    private let getBestPlacesAroundYouUseCase: GetBestPlacesAroundYouUseCase
    private let getUserLocationUseCase: GetUserLocationUseCase
    private var venues: [VenueViewModel] = []
    private var firstLoad = false
    
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
        self.ui?.loading = !firstLoad || !getUserLocationUseCase.isLocationPotentiallyGood()
        
        firstLoad = true
        
        getUserLocationUseCase.execute { locationResult in
            if let location = locationResult.value {
                self.getBestPlacesAroundYouUseCase.execute(location) { result in
                    
                    self.ui?.loading = false
                    
                    if let venueList = result.value {
                        self.venues = venueList.venues
                        self.ui?.showVenueList(venueList)
                    } else {
                        switch result.error! {
                        case .EmptyResult:
                            self.ui?.showEmptyCase(message: tr(.VenuesListNoVenuesAroundYouError))
                        case .Generic:
                            self.ui?.showError(message: tr(.VenuesListCanNotFetchVenuesError))
                        }
                    }
                }
            } else {
                self.ui?.loading = false
                
                switch locationResult.error! {
                case .CanNotFetch:
                    self.ui?.showError(message: tr(.VenuesListCanNotFetchLocationError))
                case .NoGPSAccess:
                    self.ui?.showError(message: tr(.VenuesListNoGPSAccessError))
                    self.ui?.showNoGPSAccessError()
                }
            }
        }
    }
    
    func venueSelected(venue: VenueViewModel) {
        navigator.goTo(venueDetail: venue, ofList: venues)
    }
}