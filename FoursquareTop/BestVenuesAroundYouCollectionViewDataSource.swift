
import UIKit

class BestVenuesAroundYouCollectionViewDataSource : NSObject, UICollectionViewDataSource {
    
    var venueList: VenueListViewModel?
    
    func registerCells(collectionView: UICollectionView) {
        collectionView.registerNib(
            UINib(nibName: "VenueCategoryCollectionViewCell", bundle: NSBundle.mainBundle()),
            forCellWithReuseIdentifier: VenueCategoryCollectionViewCellReuseIdentifier
        )
        
        collectionView.registerNib(
            UINib(nibName: "TopVenueCollectionViewCell", bundle: NSBundle.mainBundle()),
            forCellWithReuseIdentifier: TopVenueCollectionViewCellReuseIdentifier
        )
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return venueList?.venues.count ?? 0
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        guard let venue = venueList?.venues[indexPath.item] else {
            return UICollectionViewCell()
        }
        
        if indexPath.item == 0 {
            let cell = collectionView.dequeueReusableCellWithReuseIdentifier(TopVenueCollectionViewCellReuseIdentifier, forIndexPath: indexPath) as! TopVenueCollectionViewCell
            
            cell.configure(withVenue: venue)
            
            return cell
        } else {
            let cell = collectionView.dequeueReusableCellWithReuseIdentifier(VenueCategoryCollectionViewCellReuseIdentifier, forIndexPath: indexPath) as! VenueCategoryCollectionViewCell
            
            cell.configureWithCategory(venue.primaryCategory)
            
            return cell
        }
    }
    
    func venue(atIndexPath indexPath: NSIndexPath) -> VenueViewModel? {
        return venueList?.venues[indexPath.item]
    }
}