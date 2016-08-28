
import UIKit
@testable import FoursquareTop

class StubMapSnapshotGenerator : MapSnapshotGeneratorProtocol {
    
    var venue: VenueViewModel? = nil
    var size: CGSize? = nil
    var image: UIImage? = nil
    
    func getMapSnapshot(forVenue venue: VenueViewModel, ofSize size: CGSize, callback: (UIImage?) -> ()) {
        self.venue = venue
        self.size = size
        callback(image)
    }
}