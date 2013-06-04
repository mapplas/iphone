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
- (void)pushUserPrefScreen;
@end

@implementation AppsViewController

@synthesize userIdentRequest = _userIdentRequester;
@synthesize model = _model;
@synthesize aroundRequester = _aroundRequester;

@synthesize radarAnim = _radarAnim;
@synthesize outerImage, pointsImage, trianglesImage, blueShadowImage;
@synthesize latitudeLabel, longitudeLabel;

@synthesize table;
@synthesize cellLoading;
@synthesize loading;
@synthesize loadingText;
@synthesize cellLoadingEmpty;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.model = [[SuperModel alloc] init];
        _moreData = YES;
    }
    return self;
}

//- (void)pushNotificationScreen {
//    NotificationsViewController *notifViewController = [[NotificationsViewController alloc] initWithModel:self.model appsViewController:self];
//    [self.navigationController pushViewController:notifViewController animated:YES];
//}

- (void)pushUserPrefScreen {
    UserViewController *userViewController = [[UserViewController alloc] initWithModel:self.model];
    [self.navigationController pushViewController:userViewController animated:YES];
}

- (void)initializeNavigationBarButtons {
//    UIImage *notificationImage = [UIImage imageNamed:@"ic_menu_notifications.png"];
//    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:notificationImage style:UIBarButtonItemStyleBordered target:self action:@selector(pushNotificationScreen)];
    
    UIImage *profileImage = [UIImage imageNamed:@"ic_menu_profile.png"];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:profileImage style:UIBarButtonItemStyleBordered target:self action:@selector(pushUserPrefScreen)];
}

- (void)initializeRadarAnimation {
    CABasicAnimation *outerRotation;
    outerRotation = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
    outerRotation.fromValue = [NSNumber numberWithFloat:0];
    outerRotation.toValue = [NSNumber numberWithFloat:((360 * M_PI) / 180)];
    outerRotation.duration = 0.75f;
    outerRotation.repeatCount = 6;
    outerRotation.speed = .5;
    [self.outerImage.layer addAnimation:outerRotation forKey:@"360"];
    
    CABasicAnimation *pointsRotation;
    pointsRotation = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
    pointsRotation.fromValue = [NSNumber numberWithFloat:((360 * M_PI) / 180)];
    pointsRotation.toValue = [NSNumber numberWithFloat:0];
    pointsRotation.duration = 0.75f;
    pointsRotation.repeatCount = 6;
    pointsRotation.speed = .5;
    [self.pointsImage.layer addAnimation:pointsRotation forKey:@"360"];
    
    CABasicAnimation *trianglesRotation;
    trianglesRotation = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
    trianglesRotation.fromValue = [NSNumber numberWithFloat:0];
    trianglesRotation.toValue = [NSNumber numberWithFloat:((360 * M_PI) / 180)];
    trianglesRotation.duration = 0.75f;
    trianglesRotation.repeatCount = 6;
    trianglesRotation.speed = .3;
    [self.trianglesImage.layer addAnimation:trianglesRotation forKey:@"360"];
    
    CABasicAnimation *shadowRotation;
    shadowRotation = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
    shadowRotation.fromValue = [NSNumber numberWithFloat:((360 * M_PI) / 180)];
    shadowRotation.toValue = [NSNumber numberWithFloat:0];
    shadowRotation.duration = 0.75f;
    shadowRotation.repeatCount = 6;
    shadowRotation.speed = .3;
    [self.blueShadowImage.layer addAnimation:shadowRotation forKey:@"360"];
}

- (void)initializeLatitudeLongitude {
    latLongTextTimer = [NSTimer scheduledTimerWithTimeInterval:.1f
                                     target:self
                                   selector:@selector(setData)
                                   userInfo:nil
                                    repeats:YES];
}

-(int) getRandomNumberBetweenMin:(int)min andMax:(int)max {
	return ((arc4random() % (max-min+1)) + min);
}

- (void)setData {
    self.latitudeLabel.text = [NSString stringWithFormat:@"%d,%d", [self getRandomNumberBetweenMin:-90 andMax:90], [self getRandomNumberBetweenMin:0 andMax:99999]];
    self.longitudeLabel.text = [NSString stringWithFormat:@"%d, %d", [self getRandomNumberBetweenMin:-180 andMax:180], [self getRandomNumberBetweenMin:0 andMax:99999]];
}

- (void)stopAnimations {
    [self.outerImage.layer removeAnimationForKey:@"360"];
    [self.pointsImage.layer removeAnimationForKey:@"360"];
    [self.trianglesImage.layer removeAnimationForKey:@"360"];
    [self.blueShadowImage.layer removeAnimationForKey:@"360"];
    
    self.latitudeLabel.text = @"00.00000";
    self.longitudeLabel.text = @"00.00000";
    
    [latLongTextTimer invalidate];
    latLongTextTimer = nil;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initializeRadarAnimation];
    [self initializeLatitudeLongitude];
    
    [self initializeNavigationBarButtons];
    
    self.loadingText.text = NSLocalizedString(@"loading_cell_text", @"Apps refreshing cell text");
    
    NSString *uniqueCode = [[UIDevice currentDevice] uniqueGlobalDeviceIdentifier];
    uniqueCode = [uniqueCode stringByReplacingOccurrencesOfString:@"-" withString:@""];
    [self.model setCurrentImei:uniqueCode];
    
    // Identify user through server
    self.userIdentRequest = [[UserIdentificationRequest alloc] initWithSuperModel:self.model andViewController:self];
    [self.userIdentRequest doRequest];
    
    // Get phone's application list
    // ?? url scheme. canLaunchUrl?
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    if ([[Environment sharedInstance] appSomethingChangedInDetail]) {
        [[Environment sharedInstance] setAppSomethingChangedInDetail:NO];
        [self.model.appList sort];
        [self reloadTableDataAndScrollTop:YES];
    }
}

- (void)viewDidAppear:(BOOL)animated {
    [self checkNetworkStatus];    
}

- (void)viewDidUnload {
    [super viewDidUnload];
	_refreshHeaderView = nil;

    self.loading = nil;
    self.cellLoading = nil;
}

- (void)reloadTableDataAndScrollTop:(BOOL)scroll {
    int list_length = self.model.appList.getArray.count;
    for (int i=0; i < list_length; i++) {
        [self.model.appList.getArray addObject:[self.model.appList objectAtIndex:i]];
    }

    [self.table reloadData];
    
    if (scroll) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
        [self.table scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionTop animated:NO];
    }
}

- (void)checkNetworkStatus {
    Reachability *reach = [Reachability reachabilityWithHostname:@"www.google.com"];
    
    if (![reach isReachable]) {
        [self stopAnimations];
        
        UIAlertView *networkAlert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"network_error_dialog_title", @"Network not found error title") message:NSLocalizedString(@"network_error_dialog_message", @"Network connection not found error message") delegate:self cancelButtonTitle:NSLocalizedString(@"ok_message", @"OK message") otherButtonTitles:nil, nil];
        
        [networkAlert show];
        
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        if ([defaults objectForKey:APP_HAS_TO_RESTART] != nil) {
            [defaults setBool:YES forKey:APP_HAS_TO_RESTART];
            [defaults synchronize];
        }
    }
    else {
        if (![reach isReachableViaWiFi]) {
            Toast *wifiToast = [[Toast alloc] initAndShowIn:self.view withText:NSLocalizedString(@"wifi_error_toast", @"Obten una busqueda más precisa! Activa la conexión Wi-Fi. Funcionará incluso sin que te conectes a una red.")];
            [wifiToast show];
        }
    }
}

- (void)appsDataParsedFromServer {
    self.view = table;
    [self stopAnimations];
        
    // Endless adapter
    int height = CELL_HEIGHT;
    if (self.model.appList.getArray.count * height > self.table.frame.size.height) {
        [self.table setTableFooterView:self.cellLoading];
    } else {
        [self.table setTableFooterView:self.cellLoadingEmpty];
    }
    
    [_refreshHeaderView refreshLastUpdatedDate];
    [self doneLoadingTableViewData];
    
    // Notification DB inserter
//    NotificationDBInserter *dbInserter = [[NotificationDBInserter alloc] initWithModel:self.model viewController:self];
//    [dbInserter insertNotificationsToDB];
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
    return self.model.appList.getArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *simpleTableIdentifier = @"AppTableItem";
    
    AppCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    if (cell == nil) {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"AppCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }

    [cell setApp:[self.model.appList.getArray objectAtIndex:indexPath.row]];
    [cell setUser:self.model.user];
    [cell setCurrentLocation:self.model.currentLocation];
    [cell setCurrentDescriptiveGeoLoc:self.model.currentDescriptiveGeoLoc];
    [cell setModelList:self.model.appList];
    [cell setAppsList:self.model.appList.getArray];
    [cell setViewController:self];
    [cell setPositionInList:indexPath.row];
    [cell resetState];
    [cell loadData];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return CELL_HEIGHT;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    AppDetailViewController *appViewController = [[AppDetailViewController alloc] initWithApp:[self.model.appList objectAtIndex:indexPath.row] user:self.model.user model:self.model andLocation:self.model.currentLocation];
    [self.navigationController pushViewController:appViewController animated:YES];
}

#pragma mark -
#pragma mark Data Source Loading / Reloading Methods

- (void)reloadTableViewDataSource {
	//  should be calling your tableviews data source model to reload
    // request new location
	_reloading = YES;
    _moreData = YES;
        
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
    if (([scrollView contentOffset].y + scrollView.frame.size.height) == [scrollView contentSize].height && _moreData) {
        [self animateRadar];
        [self requestMoreApps];
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

- (void)requestMoreApps {
    Environment *environment = [Environment sharedInstance];
    AbstractUrlAddresses *urlAdresses = [environment addresses];
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    handler = [[AppGetterResponseHandler alloc] initWithModel:self.model mainController:self reverseGeocoder:geocoder location:self.model.location firstRequest:NO];
    
    appGetterConnector = [[AppGetterConnector alloc] initWithAddresses:urlAdresses responseHandler:handler];
    [appGetterConnector requestWithModel:self.model andLocation:self.model.location];
}

- (void)appsPaginationRequestOk {
    [self appsDataParsedFromServer];
}

- (void)appsPaginationRequestNok {
    _moreData = NO;
    
    [self stopAnimatingRadar];
    [self.table setTableFooterView:nil];
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
