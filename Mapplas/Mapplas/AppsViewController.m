//
//  AppsViewController.m
//  Mapplas
//
//  Created by Belén  on 17/01/13.
//  Copyright (c) 2013 Mapplas. All rights reserved.
//

#import "AppsViewController.h"
#import "NSString+UUID.h"
#import "AppDelegate.h"
#import "CoreLocationManagerConfigurator.h"

@interface AppsViewController ()

@end

@implementation AppsViewController

@synthesize userIdentRequest = _userIdentRequester;
@synthesize model = _model;
@synthesize aroundRequester = _aroundRequester;
@synthesize loadedAppsArray = _loadedAppsArray;
@synthesize loadedListCount = _loadedListCount;

@synthesize table;
@synthesize cellLoading;
@synthesize loading;
@synthesize loadingText;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.model = [[SuperModel alloc] init];
        
        self.loadedAppsArray = [[NSMutableArray alloc] init];
        self.loadedListCount = 0;
    }
    return self;
}

- (void)initializeNavigationBarButtons {
    UIImage *notificationImage = [UIImage imageNamed:@"ic_menu_notifications.png"];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:notificationImage style:UIBarButtonItemStyleBordered target:self action:nil];
    self.navigationItem.leftBarButtonItem.tintColor = [UIColor grayColor];
    
    UIImage *profileImage = [UIImage imageNamed:@"ic_menu_profile.png"];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:profileImage style:UIBarButtonItemStyleBordered target:self action:nil];
    self.navigationItem.rightBarButtonItem.tintColor = [UIColor grayColor];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initializeNavigationBarButtons];

    self.loadingText.text = NSLocalizedString(@"loading_cell_text", @"Apps refreshing cell text");
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *uniqueCode = [defaults objectForKey:UUID_USER_DEFAULTS_KEY];
    uniqueCode = [uniqueCode stringByReplacingOccurrencesOfString:@"-" withString:@""];
    [self.model setCurrentImei:uniqueCode];
    
    // Identify user through server
    self.userIdentRequest = [[UserIdentificationRequest alloc] initWithSuperModel:self.model andViewController:self];
    [self.userIdentRequest doRequest];
    
    // Get phone's application list
    // ??
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    if ([[Environment sharedInstance] appSomethingChangedInDetail]) {
        [[Environment sharedInstance] setAppSomethingChangedInDetail:NO];
        [self.model.appList sort];
        [self reloadTableDataAndScrollTop:YES];
    }
}

- (void)viewDidUnload {
    [super viewDidUnload];
	_refreshHeaderView = nil;

    self.loading = nil;
    self.cellLoading = nil;
}

- (void)reloadTableDataAndScrollTop:(BOOL)scroll {
    [scrollManager resetAppList:self.model.appList.list];
    
    [self.loadedAppsArray removeAllObjects];
    
    int maxIndex = [scrollManager getMaxCount];
    int to = 0;
    if (maxIndex > self.loadedListCount) {
        to = NUMBER_OF_APPS * self.loadedListCount;
    }
    else if(maxIndex < self.loadedListCount) {
        to = self.model.appList.count;
    }
    else {
        to = (NUMBER_OF_APPS * self.loadedListCount) + [scrollManager getRest];
    }
    
    for (int i=0; i < to; i++) {
        [self.loadedAppsArray addObject:[self.model.appList objectAtIndex:i]];
    }
    
    [self.table reloadData];
    
    if (scroll) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
        [self.table scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionTop animated:NO];
    }
}

- (void)appsDataParsedFromServer {
    // Create scroll manager
    scrollManager = [[InfiniteScrollManager alloc] initWithAppList:self.model.appList.getArray];
    [self.loadedAppsArray removeAllObjects];
    self.loadedListCount = 0;
    
    // Endless adapter
    [self.table setTableFooterView:self.cellLoading];
    //populate the tableview with some data
    [self addItemsToEndOfTableView];
    
    [_refreshHeaderView refreshLastUpdatedDate];
    [self doneLoadingTableViewData];
}

- (void)userDataLoaded {
    // Create localization requester and start searching!
    CLLocationManager *coreLocationManager = [CLLocationManager alloc];
    CoreLocationManagerConfigurator *configurator = [[CoreLocationManagerConfigurator alloc] init];
    
    locationManager = [[LocationManager alloc] initWithLocationManager:coreLocationManager managerConfigurator:configurator listener:nil];
    self.aroundRequester = [[AroundRequester alloc] initWithLocationManager:locationManager model:self.model mainViewController:self];
    [self.aroundRequester startRequesting];
    
    // Set table delegate and data source
    [self.table setDataSource:self];
    [self.table setDelegate:self];
    
    // Pull to refresh view set
    if (_refreshHeaderView == nil) {
		EGORefreshTableHeaderView *view = [[EGORefreshTableHeaderView alloc] initWithFrame:CGRectMake(0.0f, 0.0f - self.table.bounds.size.height, self.view.frame.size.width, self.table.bounds.size.height)];
		view.delegate = self;
		[self.table addSubview:view];
		_refreshHeaderView = view;
	}
}

#pragma mark -
#pragma mark Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.loadedAppsArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *simpleTableIdentifier = @"AppTableItem";
    
    AppCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    if (cell == nil) {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"AppCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }

    [cell setApp:[self.loadedAppsArray objectAtIndex:indexPath.row]];
    [cell setUserId:self.model.user.userId];
    [cell setCurrentLocation:self.model.currentLocation];
    [cell setModelList:self.model.appList];
    [cell setAppsList:self.loadedAppsArray];
    [cell setViewController:self];
    [cell setPositionInList:indexPath.row];
    [cell resetState];
    [cell loadData];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 72;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    AppDetailViewController *appViewController = [[AppDetailViewController alloc] initWithApp:[self.model.appList objectAtIndex:indexPath.row] user:self.model.user model:self.model andLocation:self.model.currentLocation];
    [self.navigationController pushViewController:appViewController animated:YES];
}

#pragma mark -
#pragma mark Data Source Loading / Reloading Methods

- (void)reloadTableViewDataSource {
	//  should be calling your tableviews data source model to reload
    [self.table reloadData];
    // request new location
	_reloading = YES;
    
    self.aroundRequester = [[AroundRequester alloc] initWithLocationManager:locationManager model:self.model mainViewController:self];
    [self.aroundRequester startRequesting];
}

- (void)doneLoadingTableViewData {
	//  model should call this when its done loading
	_reloading = NO;
	[_refreshHeaderView egoRefreshScrollViewDataSourceDidFinishedLoading:self.table];
    [self.table reloadData];
}


#pragma mark -
#pragma mark UIScrollViewDelegate Methods

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    // Pull to refress
	[_refreshHeaderView egoRefreshScrollViewDidScroll:scrollView];
    
    // Endless tableView
    if (([scrollView contentOffset].y + scrollView.frame.size.height) == [scrollView contentSize].height) {
        [self animateRadar];
        [self performSelector:@selector(stopAnimatingFooter) withObject:nil afterDelay:0.5];
        return;
	}
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {	
	[_refreshHeaderView egoRefreshScrollViewDidEndDragging:scrollView];	
}


#pragma mark -
#pragma mark EGORefreshTableHeaderDelegate Methods

- (void)egoRefreshTableHeaderDidTriggerRefresh:(EGORefreshTableHeaderView*)view {
	[self reloadTableViewDataSource];
}

- (BOOL)egoRefreshTableHeaderDataSourceIsLoading:(EGORefreshTableHeaderView*)view {
	return _reloading; // should return if data source model is reloading	
}

- (NSString *)egoRefreshTableHeaderDataSourceLastUpdated:(EGORefreshTableHeaderView*)view {
	return self.model.currentDescriptiveGeoLoc; // should return date data source was last changed
}

#pragma mark -
#pragma mark Endless UITableView

- (void)addItemsToEndOfTableView {
    
//    int appsArrayLen = self.loadedAppsArray.count;
//    int modelArrayLen = self.model.appList.count;
    
    if (self.loadedAppsArray.count < self.model.appList.count) {
        
//        int count = self.loadedListCount;
//        int maxCount = [scrollManager getMaxCount];
//        int resto = [scrollManager getRest];
        
        if (self.loadedListCount == scrollManager.getMaxCount - 1 && !scrollManager.isRestZero) {
            NSUInteger rest = scrollManager.getRest;
            for (int i = NUMBER_OF_APPS * self.loadedListCount; i <= (NUMBER_OF_APPS * self.loadedListCount) + rest - 1; i++) {
                [self.loadedAppsArray addObject:[self.model.appList objectAtIndex:i]];
            }
        }
        else {
            for (int i = NUMBER_OF_APPS * self.loadedListCount; i <= (NUMBER_OF_APPS * self.loadedListCount) + (NUMBER_OF_APPS - 1); i++) {
                [self.loadedAppsArray addObject:[self.model.appList objectAtIndex:i]];
            }
        }
        self.loadedListCount ++;
    }
}

- (void)stopAnimatingFooter {
    // If there is no more data delete row
    if (self.loadedAppsArray.count == self.model.appList.count) {
        [self.table setTableFooterView:nil];
    } else {
        [self stopAnimatingRadar];
        [self addItemsToEndOfTableView];
        [self.table reloadData];
    }
}

- (void)animateRadar {
    CABasicAnimation *fullRotation;
    fullRotation = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
    fullRotation.fromValue = [NSNumber numberWithFloat:0];
    fullRotation.toValue = [NSNumber numberWithFloat:((360 * M_PI) / 180)];
    fullRotation.duration = 0.75f;
    fullRotation.repeatCount = 3;
    
    [self.loading.layer addAnimation:fullRotation forKey:@"360"];
}

- (void)stopAnimatingRadar {
    [self.loading.layer removeAnimationForKey:@"360"];
}

@end
