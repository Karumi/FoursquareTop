
import UIKit

class VenueDetailPageViewControllerDataSource : NSObject, UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    
    private let venueDetailViewControllerProvider: VenueDetailViewControllerProvider
    private let venues: [VenueViewModel]
    private let getVenueDetailUseCase: GetVenueDetailsUseCase
    private var viewControllersCache: [String:UIViewController] = [:]
    private var visibleIndex: Int
    
    init(venueDetailViewControllerProvider: VenueDetailViewControllerProvider, venues: [VenueViewModel], initialIndex: Int, getVenueDetailUseCase: GetVenueDetailsUseCase) {
        self.venueDetailViewControllerProvider = venueDetailViewControllerProvider
        self.venues = venues
        self.getVenueDetailUseCase = getVenueDetailUseCase
        self.visibleIndex = initialIndex
        super.init()
    }
    
    // MARK: UIPageViewControllerDelegate
    func pageViewController(pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        guard let vc = pageViewController.viewControllers?.last where completed else {
            return
        }
        
        visibleIndex = getPageIndex(vc)
    }
    
    // MARK: UIPageViewControllerDataSource
    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
        var index = getPageIndex(viewController)
        
        if index == 0 {
            return nil
        }
        
        index -= 1
        prefetchPreviousAndNextDetails(index)
        
        return viewControllerAtIndex(index)
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
        var index = getPageIndex(viewController)
        
        index += 1
        prefetchPreviousAndNextDetails(index)
        
        return self.viewControllerAtIndex(index)
    }
    
    func viewControllerAtIndex(index: Int) -> UIViewController {
        NSLog("Creating new VC at index %d", index)
        
        if let venue = venues[optional:index], let vc = viewControllersCache[venue.foursquareID] {
            return vc
        } else {
            return venueDetailViewControllerProvider.getVenueDetailViewControllerAtIndex(venues, index: index)
        }
    }
    
    func prefetchPreviousAndNextDetails(index: Int) {
        [index - 2, index - 1, index + 1, index + 2].forEach(prefetchVenueAtIndex)
    }
    
    private var prefetchedVenueDetails = [String:Bool]()
    private func prefetchVenueAtIndex(index: Int) {
        if let venue = venues[optional:index] where prefetchedVenueDetails[venue.foursquareID] == nil {
            prefetchedVenueDetails[venue.foursquareID] = true
            
            getVenueDetailUseCase.execute(venue.foursquareID) { [weak self] result in
                if let welf = self, fetchedVenueDetail = result.value {
                    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)) {
                        objc_sync_enter(welf.viewControllersCache)
                        welf.viewControllersCache[fetchedVenueDetail.foursquareID] = welf.venueDetailViewControllerProvider.getVenueDetailViewControllerAtIndex(
                            welf.venues,
                            index: index
                        )
                        objc_sync_exit(welf.viewControllersCache)
                    }
                }
            }
        }
    }
    
    private func getPageIndex(viewController: UIViewController) -> Int {
        return (viewController as! VenueDetailViewController).pageIndex
    }
}
