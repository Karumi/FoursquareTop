
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
    let status: String?
    let price: VenuePrice?
    let phrases: [VenuePhraseViewModel]
    
    let likesCount: Int
    let rating: Double?
    
    let location: CLLocation
    let distance: Double?
    
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
        return menuURL != nil || phone != nil
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
        options.camera = MKMapCamera(
            lookingAtCenterCoordinate: CLLocationCoordinate2D(
                latitude: location.coordinate.latitude,
                longitude: location.coordinate.longitude - 0.005
            ),
            fromDistance: 1000,
            pitch: 0,
            heading: 0
        )
        
        let calculator = VenueDetailCollectionViewCellHeightCalculator(availableWidth: UIScreen.mainScreen().bounds.width)
        let height = calculator.heightForCell(forType: .Information)
        
        options.size = CGSize(width: UIScreen.mainScreen().bounds.width, height: height)
        
        let snapshotter = MKMapSnapshotter(options: options)
        let executeOnBackground = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)
        snapshotter.startWithQueue(executeOnBackground) { (snapshot, error) in
            
            guard let snapshot = snapshot else {
                callback(nil)
                return
            }
            
            let pin = MKPinAnnotationView(annotation: nil, reuseIdentifier: nil)
            let image = snapshot.image
            
            UIGraphicsBeginImageContextWithOptions(image.size, true, image.scale)
            image.drawAtPoint(CGPoint.zero)
            
            let visibleRect = CGRect(origin: CGPoint.zero, size: image.size)
            for annotation in mapView.annotations {
                var point = snapshot.pointForCoordinate(annotation.coordinate)
                if visibleRect.contains(point) {
                    point.x = point.x + pin.centerOffset.x - (pin.bounds.size.width / 2)
                    point.y = point.y + pin.centerOffset.y - (pin.bounds.size.height / 2)
                    pin.image?.drawAtPoint(point)
                }
            }
            
            let compositeImage = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            
            dispatch_async(dispatch_get_main_queue()) {
                callback(compositeImage)
            }
        }
    }
    
    var topTips: [VenueTipViewModel] {
        let sorted = tips.sort { $0.likesCount > $1.likesCount }
        return Array(sorted[0..<min(sorted.count, 3)])
    }
}
