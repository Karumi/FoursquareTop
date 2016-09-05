
import Foundation

struct VenueListViewModel {
    let venues: [VenueViewModel]
    
    init(venues: [VenueViewModel]) {
        guard venues.count > 0 else {
            self.venues = []
            return
        }
        
        let allVenuesWithCategories: [VenueViewModel] = Array(venues[1..<venues.count]).flatMap {
            let primaryCategories = $0.categories.filter { $0.primary }
            guard primaryCategories.count > 0 else {
                return nil
            }
            
            return $0
        }
        
        let topVenuesPerCategory = allVenuesWithCategories.reduce([String:VenueViewModel]()) { (dict, venue) in
            
            var copy = dict
            if let storedVenue = dict[venue.primaryCategory.identifier] {
                if venue.rating > storedVenue.rating {
                    copy[venue.primaryCategory.identifier] = venue
                }
            } else {
                copy[venue.primaryCategory.identifier] = venue
            }
            
            return copy
        }.values
        
        let resultingVenues = Array(topVenuesPerCategory)

        guard resultingVenues.count > 1 else {
            self.venues = resultingVenues
            return
        }
        
        let topVenue = resultingVenues.sort { $0.rating > $1.rating }.first!
        let allVenuesButTheTopSorted: [VenueViewModel] = Array(resultingVenues[1..<resultingVenues.count]).sort {
            $0.primaryCategory.names.get(forType: .Regular) < $1.primaryCategory.names.get(forType: .Regular)
        }
        
        self.venues = [topVenue] + allVenuesButTheTopSorted
    }
}