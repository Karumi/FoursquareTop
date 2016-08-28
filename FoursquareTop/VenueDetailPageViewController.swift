
import UIKit

class VenueDetailPageViewController : FTViewController {
    
    private var pageViewController: UIPageViewController!
    var dataSource: VenueDetailPageViewControllerDataSource!
    
    var initialIndex: Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pageViewController = UIPageViewController(
            transitionStyle: .Scroll,
            navigationOrientation: .Horizontal,
            options: [
                UIPageViewControllerOptionInterPageSpacingKey: 2
            ]
        )
        
        view.backgroundColor = .whiteColor()
        pageViewController.view.backgroundColor = .whiteColor()
        pageViewController.dataSource = dataSource
        pageViewController.delegate = dataSource
        
        let vc = dataSource.viewControllerAtIndex(initialIndex)
        
        pageViewController.setViewControllers([vc], direction: .Forward, animated: false, completion: nil)
        pageViewController.willMoveToParentViewController(self)
        addChildViewController(pageViewController)
        view.addSubview(pageViewController.view)
        pageViewController.didMoveToParentViewController(self)
    }
}
