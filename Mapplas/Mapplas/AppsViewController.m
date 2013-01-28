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

@synthesize table;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
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
    
    self.model = [[SuperModel alloc] init];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *uniqueCode = [defaults objectForKey:UUID_USER_DEFAULTS_KEY];
    uniqueCode = [uniqueCode stringByReplacingOccurrencesOfString:@"-" withString:@""];
    [self.model setCurrentImei:uniqueCode];
    
    // Identify user through server
    self.userIdentRequest = [[UserIdentificationRequest alloc] initWithSuperModel:self.model andViewController:self];
    [self.userIdentRequest doRequest];
    
    // Get phone's application list
    
}

- (void)viewDidUnload {
	_refreshHeaderView = nil;
}

- (void)appsDataParsedFromServer {
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
	return self.model.appList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *simpleTableIdentifier = @"AppTableItem";
    
    AppCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    if (cell == nil) {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"AppCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }

    [cell setApp:[self.model.appList objectAtIndex:indexPath.row]];
    [cell resetState];
    [cell loadData];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 72;
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
	[_refreshHeaderView egoRefreshScrollViewDidScroll:scrollView];
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

@end
