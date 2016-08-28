
import UIKit
import MapKit

protocol MapSnapshotGeneratorProtocol : class {
    func getMapSnapshot(forVenue venue: VenueViewModel, ofSize size: CGSize, callback: (UIImage?) -> ())
}

class MapSnapshotGenerator : MapSnapshotGeneratorProtocol {
    
    private var snaphotCache: [String:UIImage] = [:]
    
    func getMapSnapshot(forVenue venue: VenueViewModel, ofSize size: CGSize, callback: (UIImage?) -> ()) {
        
        guard snaphotCache[venue.foursquareID] == nil else {
            callback(snaphotCache[venue.foursquareID])
            return
        }
        
        let metersPerMile: CLLocationDistance = 1609.344
        
        let region = MKCoordinateRegionMakeWithDistance(venue.location.coordinate, 0.2 * metersPerMile, 0.2 * metersPerMile)
        let mapView = MKMapView()
        mapView.translatesAutoresizingMaskIntoConstraints = false
        
        let annotation = MKPointAnnotation()
        annotation.coordinate = venue.location.coordinate
        mapView.addAnnotation(annotation)
        mapView.setRegion(region, animated: false)
        mapView.userInteractionEnabled = false
        
        let options = MKMapSnapshotOptions()
        options.camera = MKMapCamera(
            lookingAtCenterCoordinate: CLLocationCoordinate2D(
                latitude: venue.location.coordinate.latitude,
                longitude: venue.location.coordinate.longitude - 0.005
            ),
            fromDistance: 1000,
            pitch: 0,
            heading: 0
        )
        
        options.size = size
        
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
                self.snaphotCache[venue.foursquareID] = compositeImage
                callback(compositeImage)
            }
        }
    }
}