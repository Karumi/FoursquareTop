
import Foundation
import SafariServices
import MapKit

enum MapProvider : String {
    case Apple
    case Google
    
    static var all: [MapProvider] = [.Apple, .Google]
}

protocol VenueDetailNavigator {
    func dismissVenueDetail()
    func goToMenu(venueDetail venue: VenueViewModel)
    func goToPhotoViewer(venueDetail venue: VenueViewModel, selectedIndex: Int, delegate: VenueDetailGalleryViewControllerDelegate)
    func closePhotoViewer()
    func call(venueDetail venue: VenueViewModel)
    func openInFoursquare(venueDetail venue: VenueViewModel)
    func openInMaps(venueDetail venue: VenueViewModel, usingProvider: MapProvider)
}

extension RootNavigator : VenueDetailNavigator {
    func goToMenu(venueDetail venue: VenueViewModel) {
        guard let url = venue.menuURL else {
            return
        }
        
        goTo(url: url)
    }
    
    func dismissVenueDetail() {
        currentNavigationController?.popViewControllerAnimated(true)
    }
    
    func call(venueDetail venue: VenueViewModel) {
        guard let phone = venue.phone, let url = NSURL(string: "tel://\(phone)") else {
            return
        }
        
        UIApplication.sharedApplication().openURL(url)
    }
    
    func openInFoursquare(venueDetail venue: VenueViewModel) {
        guard let url = venue.foursquareURL else {
            return
        }
        
        UIApplication.sharedApplication().openURL(url)
    }

    func openInMaps(venueDetail venue: VenueViewModel, usingProvider provider: MapProvider) {
        
        switch provider {
        case .Apple:
            let placemark = MKPlacemark(coordinate: venue.location.coordinate,
                addressDictionary: nil)
            
            let mapItem = MKMapItem(placemark:placemark)
            mapItem.name = venue.name
            
            let launchOptions = [MKLaunchOptionsDirectionsModeKey : MKLaunchOptionsDirectionsModeWalking]
            let currentLocationMapItem = MKMapItem.mapItemForCurrentLocation()
            MKMapItem.openMapsWithItems([currentLocationMapItem, mapItem], launchOptions: launchOptions)

        case .Google:
            
            let lat = String(venue.location.coordinate.latitude)
            let lng = String(venue.location.coordinate.longitude)
            let latLongQuery = "\(lat),\(lng)"
            
            if let url = NSURL(string: "comgooglemaps-x-callback://?daddr=\(latLongQuery)&directionsmode=walking&x-success=sourceapp://?resume=true&x-source=Ftop") {
                print(url.absoluteString)
                UIApplication.sharedApplication().openURL(url)
            }
        }
    }
    
    func goToPhotoViewer(venueDetail venue: VenueViewModel, selectedIndex: Int, delegate: VenueDetailGalleryViewControllerDelegate) {
        let vc = appCompositionRoot.venue.getPhotoViewerViewController(venue, initialIndex: selectedIndex, delegate: delegate)
        currentNavigationController?.presentViewController(vc, animated: true, completion: nil)
    }
    
    func closePhotoViewer() {
        currentlyPresentedViewController?.dismissViewControllerAnimated(true, completion: nil)
    }
    
    private func goTo(url url: NSURL) {
        let vc = SFSafariViewController(
            URL: url
        )
        
        currentNavigationController?.presentViewController(vc, animated: true, completion: nil)
    }
}