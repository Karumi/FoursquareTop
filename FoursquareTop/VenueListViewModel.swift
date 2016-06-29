
import Foundation

struct VenueListViewModel {
    let venues: [VenueViewModel]
    
    var topVenue: VenueViewModel? {
        return venues.first!
    }
    
    var allVenuesButTopVenue: [VenueViewModel] {
        guard venues.count > 1 else {
            return []
        }
        
        return Array(venues[1..<venues.count])
    }
    
    var allCategories: [VenueCategoryViewModel] {
        return Array<VenueCategoryViewModel>(
            Set<VenueCategoryViewModel>(venues.flatMap { $0.categories })
        ).sort { $0.names.get(forType: .Regular) < $1.names.get(forType: .Regular) }
    }
    
    func topVenue(forCategoryId categoryId: String)-> VenueViewModel? {
        return venues.filter { $0.foursquareID == categoryId }.first
    }
}