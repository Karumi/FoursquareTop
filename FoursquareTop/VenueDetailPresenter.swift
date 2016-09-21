
import Foundation
import MapKit

class VenueDetailPresenter : Presenter {
    
    private let foursquareID: String
    private weak var ui: VenueDetailUI?
    private let useCase: GetVenueDetailsUseCase
    private let navigator: VenueDetailNavigator
    private let environment: EnvironmentProtocol
    private let snapshotGenerator: MapSnapshotGeneratorProtocol
    private var venue: VenueViewModel?
    
    init(ui: VenueDetailUI, useCase: GetVenueDetailsUseCase, foursquareID: String, navigator: VenueDetailNavigator, environment: EnvironmentProtocol, snapshotGenerator: MapSnapshotGeneratorProtocol) {
        self.ui = ui
        self.useCase = useCase
        self.foursquareID = foursquareID
        self.navigator = navigator
        self.environment = environment
        self.snapshotGenerator = snapshotGenerator
    }
    
    func viewWillAppear() {
        ui?.loading = true
        
        useCase.execute(foursquareID) { result in
            self.ui?.loading = false
            
            if let ui = self.ui, venue = result.value {
                self.venue = venue
                ui.showVenue(venue)
                
                self.snapshotGenerator.getMapSnapshot(
                    forVenue: venue,
                    ofSize: CGSize(width: ui.width, height: VenueDetailInformationCellProvider.height)
                ) { image in
                    if let image = image {
                        ui.showMap(image)
                    }
                }
                
            } else {
                self.ui?.showError(message: tr(.VenueDetailCanNotFetchVenueError))
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
    
    func galleryPhotoSelected(venue: VenueViewModel, selectedIndex: Int, delegate: VenueDetailGalleryViewControllerDelegate) {
        navigator.goToPhotoViewer(venueDetail: venue, selectedIndex: selectedIndex, delegate: delegate)
    }
}
