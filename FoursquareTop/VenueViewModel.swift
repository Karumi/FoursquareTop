
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
    
    var primaryCategory: VenueCategoryViewModel {
        return categories.filter { $0.primary }.first!
    }
    
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
        return menuURL != nil
    }
    
    var topTips: [VenueTipViewModel] {
        let sorted = tips.sort { $0.likesCount > $1.likesCount }
        return Array(sorted[0..<min(sorted.count, 3)])
    }
}
