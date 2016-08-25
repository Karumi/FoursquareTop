
import Foundation
import MapKit

enum VenuePrice : String {
    case Cheap = "$"
    case Medium = "$$"
    case Expensive = "$$$"
    case VeryExpensive = "$$$$"
    
    init(value: Int) {
        self = Cheap
        
        if value == 2 {
            self = Medium
        } else if value == 3 {
            self = Expensive
        } else if value == 4 {
            self = VeryExpensive
        }
    }
}

struct VenueViewModel {
    let foursquareID: String;
    let name: String
    let URL: NSURL?
    let foursquareURL: NSURL?
    let menuURL: NSURL?
    let reservationsURL: NSURL?
    let websiteURL: NSURL?
    let phone: String?
    let address: String?
    let price: VenuePrice?
    
    let likesCount: Int
    let rating: Double?
    
    let location: CLLocation
    let distance: Double
    
    let categories: [VenueCategoryViewModel]
    let tips: [VenueTipViewModel]
    let photos: [VenuePhotoViewModel]
    
    var formattedPrice: String? {
        return price?.rawValue
    }
    
    var formattedRating: String? {
        guard let rating = rating else {
            return nil
        }
        
        return String(format: "%0.1f", rating)
    }
    
    var formattedCategories: String {
        return categories.map { $0.names.get(forType: .Short) }.joinWithSeparator(", ")
    }
    
    var canOpenFoursquareApp: Bool {
        guard let foursquareURL = foursquareURL else {
            return false
        }
        
        return UIApplication.sharedApplication().canOpenURL(foursquareURL)
    }
    
    var hasSecondaryActions: Bool {
        return menuURL != nil || reservationsURL != nil
    }
    
    func getMapSnapshot(callback: (UIImage?) -> ()) {
        
        let metersPerMile: CLLocationDistance = 1609.344
        
        let region = MKCoordinateRegionMakeWithDistance(location.coordinate, 0.2 * metersPerMile, 0.2 * metersPerMile)
        let mapView = MKMapView()
        mapView.translatesAutoresizingMaskIntoConstraints = false
        
        let annotation = MKPointAnnotation()
        annotation.coordinate = location.coordinate
        mapView.addAnnotation(annotation)
        mapView.setRegion(region, animated: false)
        mapView.userInteractionEnabled = false
        
        let options = MKMapSnapshotOptions()
        options.region = region
        options.scale = UIScreen.mainScreen().scale
        
        let height = DetailCellType.Information.heightForCell(nil)
        
        options.size = CGSize(width: UIScreen.mainScreen().bounds.width, height: height)
        
        let snapshotter = MKMapSnapshotter(options: options)
        let executeOnBackground = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)
        snapshotter.startWithQueue(executeOnBackground) { (snapshot, error) in
            dispatch_async(dispatch_get_main_queue()) {
                snapshot?.image
                callback(snapshot?.image)
            }
        }
        
    }
}
