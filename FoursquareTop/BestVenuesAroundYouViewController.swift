
import UIKit

class BestVenuesAroundYouViewController : FTViewController, BestVenuesAroundYouUI, UICollectionViewDelegateFlowLayout {
    
    var venuesAroudYouPresenter: BestVenuesAroundYouPresenter!
    override var presenter: Presenter? {
        return venuesAroudYouPresenter
    }
    
    private var collectionView: UICollectionView!
    private var dataSource = BestVenuesAroundYouDataSource()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        automaticallyAdjustsScrollViewInsets = false
        
        initCollectionView()
        
        navigationController?.navigationBar.topItem?.title = NSLocalizedString("BestPlacesAround.Title", comment: "Best places to eat around you screen title")
    }
    
    // MARK: BestVenuesAroundYouUI
    func showVenueList(venueList: VenueListViewModel) {
        dataSource.venueList = venueList
        collectionView.reloadData()
    }

    // MARK: UICollectionViewDelegateFlowLayout
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        if indexPath.item == 0 {
            return CGSize(width: view.bounds.width, height: 200)
        } else {
            return CGSize(width: view.bounds.width, height: 60)
        }
    }
    
    // MARK: Private
    func initCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 1
        
        collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.dataSource = dataSource
        collectionView.delegate = self
        collectionView.backgroundColor = .whiteColor()
        
        view.addSubview(collectionView)
        
        collectionView.leadingAnchor.constraintEqualToAnchor(view.leadingAnchor).active = true
        collectionView.trailingAnchor.constraintEqualToAnchor(view.trailingAnchor).active = true
        collectionView.topAnchor.constraintEqualToAnchor(topLayoutGuide.bottomAnchor).active = true
        collectionView.bottomAnchor.constraintEqualToAnchor(bottomLayoutGuide.topAnchor).active = true
        
        dataSource.registerCells(collectionView)
    }
}

//
//static int const kNumberOfRestaurantsToFetch = 50;
//static int const lSearchRadius = 1000;
//static int const kLocationUpdatesMinimumInterval = 60;
//
//static NSString* const kFoodType = @"food";
//static NSString* const kAnalyticsTimingCategory = @"timing";
//static NSString* const kAnalyticsScreenName = @"Home Screen";
//static NSString* const kAnalyticsLocationTimeTrackingEventName = @"Good enough location";
//static NSString* const kAnalyticsFoursquareQueryTimeTrackingEventName = @"Foursquare query";
//static NSString* const kLocatingUserLabelText = @"Locating you";
//static NSString* const kLocatingRestaurantLabelText = @"Locating the best open place to eat";
//static NSString* const kNavigationBarText = @"Best open place to eat around you";
//
//static int const kLocationTimeoutInSeconds = 10.0;
//static NSString *const kCellReuseIdentifier = @"kFoursquareCategoryCell";
//static NSString *const kHeaderViewReuseIdentifier = @"kRestaurantDetailsHeaderView";
//
//@interface KMViewController () <UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>
//
//@property (weak, nonatomic) IBOutlet UIView *loadingView;
//@property (weak, nonatomic) IBOutlet UILabel *loadingLabel;
//
//@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *loadingSpinner;
//@property (weak, nonatomic) IBOutlet UIView *locationServicesDisabledView;
//@property (weak, nonatomic) IBOutlet UIView *noResultsView;
//
//@property (strong, nonatomic) UICollectionView *categoriesCollectionView;
//@property (strong, nonatomic) KMVenue *topVenue;
//@property (strong, nonatomic) KMVenueList *topVenueList;
//@property (strong, nonatomic) KMCategoryList *categoriesAroundYou;
//
//@property (nonatomic, strong) CLLocation *lastKnownLocation;
//@property (nonatomic, strong) CLLocation *lastProcessedLocation;
//@property (strong, nonatomic) NSTimer *locationTimeoutTimer;
//@property (assign, nonatomic) CGFloat ratio;
//@property (assign, nonatomic) CGFloat screenWidth;
//
//@property (nonatomic) NSDate *loadStartTime;
//
//@end
//
//@implementation KMViewController
//
//- (void)viewDidLoad
//{
//    [super viewDidLoad];
//    self.screenWidth = [UIScreen mainScreen].bounds.size.width;
//    self.ratio = 138/320;
//    self.loadStartTime = [NSDate date];
//
//    [self.categoriesCollectionView registerNib:[UINib nibWithNibName:NSStringFromClass([KMFoursquareCategoryCell class])
//    bundle:nil]
//    forCellWithReuseIdentifier:kCellReuseIdentifier];
//    
//    [self.categoriesCollectionView registerNib:[UINib nibWithNibName:NSStringFromClass([KMRestaurantDetailsReusableView class])
//    bundle:nil]
//    forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:kHeaderViewReuseIdentifier];
//    
//    [self.view addSubview:self.categoriesCollectionView];
//    
//    [self.categoriesCollectionView autoPinToTopLayoutGuideOfViewController:self withInset:0];
//    [self.categoriesCollectionView autoPinToBottomLayoutGuideOfViewController:self withInset:0];
//    [self.categoriesCollectionView autoPinEdgeToSuperviewEdge:ALEdgeLeft];
//    [self.categoriesCollectionView autoPinEdgeToSuperviewEdge:ALEdgeRight];
//    
//    [self.categoriesCollectionView setNeedsLayout];
//    [self.categoriesCollectionView reloadData];
//    
//    [self showLocationInProgressFeedback];
//    [self getPosition:NO finished:nil];
//    }
//    
//    - (void)getPosition:(BOOL)force finished:(void (^)(void))finishedBlock
//{
//    // Avoid changing all the results when getting back to the app if there is not a significant location change
//    
//    
//    BOOL shouldRefresh = YES;
//    if(!force && self.lastProcessedLocation != nil) {
//        NSDate* eventDate = self.lastProcessedLocation.timestamp;
//        NSTimeInterval howRecent = [eventDate timeIntervalSinceNow];
//        if (fabs(howRecent) > kLocationUpdatesMinimumInterval) {
//            shouldRefresh = NO;
//        }
//    }
//    
//    if(shouldRefresh) {
//        INTULocationManager *locMgr = [INTULocationManager sharedInstance];
//        [locMgr requestLocationWithDesiredAccuracy:INTULocationAccuracyBlock
//            timeout:kLocationTimeoutInSeconds
//            delayUntilAuthorized:YES
//            block:^(CLLocation *currentLocation, INTULocationAccuracy achievedAccuracy, INTULocationStatus status) {
//            if (status == INTULocationStatusSuccess) {
//            if (finishedBlock) {
//            finishedBlock();
//            }
//            self.lastProcessedLocation = currentLocation;
//            [self showBestPlacesAroundYou:currentLocation];
//            }
//            else {
//            [self getPosition:force finished:finishedBlock];
//            }
//            }];
//        
//    }
//    }
//    
//    - (void)viewDidAppear:(BOOL)animated {
//        self.screenName = kAnalyticsScreenName;
//        [super viewDidAppear:animated];
//}
//
//-(void)trackTimeInGA:(NSTimeInterval)loadTime name:(NSString *)name
//{
//    // May return nil if a tracker has not already been initialized with a
//    // property ID.
//    id tracker = [[GAI sharedInstance] defaultTracker];
//    
//    [tracker send:[[GAIDictionaryBuilder createTimingWithCategory:kAnalyticsTimingCategory
//        interval:[NSNumber numberWithDouble:loadTime]
//        name:name
//        label:nil] build]];
//    }
//    
//    - (void)restaurantTapped:(UITapGestureRecognizer *)sender {
//        KMVenueDetailsViewController *vc = [[KMVenueDetailsViewController alloc] initWithVenue:self.topVenue];
//        
//        [self.navigationController pushViewController:vc animated:YES];
//        }
//        
//        - (void)showLocationDisabledFeedback {
//            NSLog(@"showLocationDisabledFeedback");
//            self.navigationController.navigationBarHidden = YES;
//            self.locationServicesDisabledView.hidden = NO;
//            self.loadingView.hidden = YES;
//            self.noResultsView.hidden = YES;
//            self.categoriesCollectionView.hidden = YES;
//            }
//            
//            - (void)showLocationInProgressFeedback {
//                NSLog(@"showLocationInProgressFeedback");
//                self.loadingLabel.text = kLocatingUserLabelText;
//                [self.loadingSpinner startAnimating];
//                
//                self.navigationController.navigationBarHidden = YES;
//                self.locationServicesDisabledView.hidden = YES;
//                self.loadingView.hidden = NO;
//                self.noResultsView.hidden = YES;
//                self.categoriesCollectionView.hidden = YES;
//                }
//                
//                - (void)showNoResultsFeedback {
//                    NSLog(@"showNoResultsFeedback");
//                    self.navigationController.navigationBarHidden = YES;
//                    self.locationServicesDisabledView.hidden = YES;
//                    self.loadingView.hidden = YES;
//                    self.noResultsView.hidden = NO;
//                    self.categoriesCollectionView.hidden = YES;
//                    }
//                    
//                    - (void)hideFeedback {
//                        NSLog(@"hideFeedback");
//                        self.navigationController.navigationBarHidden = NO;
//                        self.locationServicesDisabledView.hidden = YES;
//                        self.loadingView.hidden = YES;
//                        self.noResultsView.hidden = YES;
//                        
//                        self.categoriesCollectionView.hidden = NO;
//                        [self.loadingSpinner stopAnimating];
//}
//
//#pragma mark - UICollectionView Datasource
//
//- (NSInteger)collectionView:(UICollectionView *)view numberOfItemsInSection:(NSInteger)section
//{
//    return [self.categoriesAroundYou.categories count];
//    }
//    
//    - (NSInteger)numberOfSectionsInCollectionView: (UICollectionView *)collectionView
//{
//    return 1;
//    }
//    
//    - (UICollectionViewCell *)collectionView:(UICollectionView *)cv cellForItemAtIndexPath:(NSIndexPath *)indexPath
//{
//    KMFoursquareCategoryCell *cell = [cv dequeueReusableCellWithReuseIdentifier:kCellReuseIdentifier forIndexPath:indexPath];
//    KMCategory *category = [self.categoriesAroundYou.categories objectAtIndex:indexPath.row];
//    
//    cell.categoryNameLabel.text = category.shortName;
//    return cell;
//    }
//    
//    - (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
//{
//    UICollectionReusableView *reusableview = nil;
//    
//    if (kind == UICollectionElementKindSectionHeader) {
//        KMRestaurantDetailsReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:kHeaderViewReuseIdentifier forIndexPath:indexPath];
//        
//        if(self.topVenue != nil)
//        {
//            [headerView setFromVenue:self.topVenue];
//            
//            if(self.categoriesAroundYou.categories.count == 0)
//            {
//                [headerView showNoMoreCategoriesFeedback];
//            } else
//            {
//                [headerView hideNoMoreCategoriesFeedback];
//            }
//            
//            if(self.topVenue.backgroundThumb)
//            {
//                headerView.backgroundImage = [self.topVenue.backgroundThumb copy];
//            }
//            
//            UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(restaurantTapped:)];
//            [headerView.topRestaurantViewContainer addGestureRecognizer:tapGesture];
//        }
//        
//        reusableview = headerView;
//    }
//    
//    return reusableview;
//}
//
//#pragma mark - UICollectionViewDelegate
//- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
//{
//    KMCategory *selectedCategory = [self.categoriesAroundYou.categories objectAtIndex:indexPath.row];
//    KMVenue *topVenueForCategory = [self.topVenueList topVenueForCategory:selectedCategory.foursquareID];
//    
//    KMVenueDetailsViewController *vc = [[KMVenueDetailsViewController alloc] initWithVenue:topVenueForCategory];
//    
//    [self.navigationController pushViewController:vc animated:YES];
//    }
//    
//    - (CGSize)collectionView:(UICollectionView *)collectionView
//layout:(UICollectionViewLayout *)collectionViewLayout
//sizeForItemAtIndexPath:(NSIndexPath *)indexPath
//{
//    return CGSizeMake(self.screenWidth, 60);
//    }
//    
//    - (CGSize) collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
//{
//    return CGSizeMake(self.screenWidth, 150);
//}
//-(void)showBestPlacesAroundYou:(CLLocation *)location
//{
//    self.loadingLabel.text = kLocatingRestaurantLabelText;
//    
//    // If the event is recent, do something with it.
//    [[KMFoursquareAPI sharedAPI]
//        venueExploreRecommendedNearByLatitude:[NSNumber numberWithDouble:location.coordinate.latitude]
//        longitude:[NSNumber numberWithDouble:location.coordinate.longitude]
//        near:nil
//        accuracyLL:nil
//        altitude:nil
//        accuracyAlt:nil
//        query:nil
//        limit:[NSNumber numberWithInt:kNumberOfRestaurantsToFetch]
//        offset:nil
//        radius:[NSNumber numberWithInt:lSearchRadius]
//        section:kFoodType
//        novelty:nil
//        sortByDistance:NO
//        openNow:YES
//        venuePhotos:YES
//        price:nil
//        callback:^(BOOL success, id result){
//        
//        [self trackTimeInGA:[self.loadStartTime timeIntervalSinceNow]
//        name:kAnalyticsFoursquareQueryTimeTrackingEventName
//        ];
//        
//        self.topVenueList = (KMVenueList *)result;
//        
//        if(success == NO || self.topVenueList.venues.count == 0)
//        {
//        // TODO treat errors differently?
//        [self showNoResultsFeedback];
//        } else
//        {
//        self.topVenue = [self.topVenueList topVenue];
//        [self hideFeedback];
//        
//        __block KMCategoryList *filteredCategoryList = [[KMCategoryList alloc] init];
//        
//        [self.topVenueList.categories.categories enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
//        KMCategory *category = (KMCategory *)obj;
//        if(![self.topVenue.categoryList.categories containsObject:category])
//        {
//        [filteredCategoryList addCategory:category];
//        }
//        }];
//        self.categoriesAroundYou = filteredCategoryList;
//        
//        if(self.topVenue.photoList.photos.count > 0)
//        {
//        KMPhoto *photo = (KMPhoto *)self.topVenue.photoList.photos[0];
//        CGSize size = CGSizeMake(self.screenWidth, self.screenWidth * self.ratio);
//        NSURL *thumbUrl = [photo
//        thumbURLForWidth:[NSNumber numberWithInt:self.screenWidth]
//        andHeight:[NSNumber numberWithFloat:(self.screenWidth * self.ratio)]];
//        [[LRImageManager sharedManager] imageFromURL:thumbUrl size:size completionHandler:^(UIImage *image, NSError *error) {
//        
//        self.topVenue.backgroundThumb = image;
//        dispatch_async(dispatch_get_main_queue(), ^{
//        [self hideFeedback];
//        [self.categoriesCollectionView reloadData];
//        });
//        }];
//        }
//        
//        [self.categoriesCollectionView reloadData];
//        }
//        }];
//}
//
//-(void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status
//{
//    if (status == kCLAuthorizationStatusDenied) {
//        [self showLocationDisabledFeedback];
//        [manager stopUpdatingLocation];
//        NSLog(@"Location auth revoked");
//    } else if (status == kCLAuthorizationStatusAuthorized) {
//        [self showLocationInProgressFeedback];
//        [manager startUpdatingLocation];
//        NSLog(@"Location auth ok");
//    }
//}
//
//@end
