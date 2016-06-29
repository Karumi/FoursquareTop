
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
}

//@property (nonatomic, strong) UIImage* backgroundThumb;
//@property (nonatomic) BOOL fullVenue;
