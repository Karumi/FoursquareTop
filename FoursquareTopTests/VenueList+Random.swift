
import Foundation
import MapKit

@testable import FoursquareTop

extension VenueListViewModel {
    
    static func random(venueCount count: Int = 10, categoryCount: Int = 5) -> VenueListViewModel {
        var venues: [VenueViewModel] = []
        
        for i in 0..<count {
            var categories: [VenueCategoryViewModel] = []
            
            for cat in 0..<Int.random(1, max: categoryCount) {
                categories.append(
                    VenueCategoryViewModel.build("\(i)_\(cat)")
                )
            }
            
            venues.append(
                VenueViewModel(
                    foursquareID: "foursquare_id_\(i)",
                    name: "Venue name \(i)",
                    URL: nil,
                    foursquareURL: nil,
                    menuURL: nil,
                    reservationsURL: nil,
                    websiteURL: nil,
                    phone: "66655544\(i)",
                    address: nil,
                    status: nil,
                    price: .Expensive,
                    phrases: [],
                    likesCount: 10,
                    rating: Double.random(1, max: 10),
                    location: CLLocation.random(),
                    distance: Double.random(10, max: 1000),
                    categories: categories,
                    tips: [],
                    photos: []
                )
            )
        }
        
        return VenueListViewModel(venues: venues)
    }
}
