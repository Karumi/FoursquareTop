
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
        
        return viewControllerAtIndex(index)
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
        var index = getPageIndex(viewController)
        
        if index >= venues.count - 1  {
            return nil
        }
        
        index += 1
        
        return viewControllerAtIndex(index)
    }
    
    func viewControllerAtIndex(index: Int) -> UIViewController {
        return venueDetailViewControllerProvider.getVenueDetailViewControllerAtIndex(venues, index: index)
    }
    
    private func getPageIndex(viewController: UIViewController) -> Int {
        return (viewController as! VenueDetailViewController).pageIndex
    }
}
