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
@synthesize radarImage1, radarImage2, radarImage3, radarImage4, radarImage5;
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
    CABasicAnimation *rotation1;
    rotation1 = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
    rotation1.fromValue = [NSNumber numberWithFloat:0];
    rotation1.toValue = [NSNumber numberWithFloat:((360 * M_PI) / 180)];
    rotation1.duration = 0.75f;
    rotation1.repeatCount = 15;
    rotation1.speed = .15;
    [self.radarImage1.layer addAnimation:rotation1 forKey:@"360"];
    
    CABasicAnimation *rotation2;
    rotation2 = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
    rotation2.fromValue = [NSNumber numberWithFloat:((360 * M_PI) / 180)];
    rotation2.toValue = [NSNumber numberWithFloat:0];
    rotation2.duration = 0.75f;
    rotation2.repeatCount = 15;
    rotation2.speed = .4;
    [self.radarImage2.layer addAnimation:rotation2 forKey:@"360"];
    
    CABasicAnimation *rotation3;
    rotation3 = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
    rotation3.fromValue = [NSNumber numberWithFloat:0];
    rotation3.toValue = [NSNumber numberWithFloat:((360 * M_PI) / 180)];
    rotation3.duration = 0.75f;
    rotation3.repeatCount = 15;
    rotation3.speed = .3;
    [self.radarImage3.layer addAnimation:rotation3 forKey:@"360"];
    
    CABasicAnimation *rotation4;
    rotation4 = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
    rotation4.fromValue = [NSNumber numberWithFloat:((360 * M_PI) / 180)];
    rotation4.toValue = [NSNumber numberWithFloat:0];
    rotation4.duration = 0.75f;
    rotation4.repeatCount = 15;
    rotation4.speed = .25;
    [self.radarImage4.layer addAnimation:rotation4 forKey:@"360"];
    
    CABasicAnimation *rotation5;
    rotation5 = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
    rotation5.fromValue = [NSNumber numberWithFloat:((360 * M_PI) / 180)];
    rotation5.toValue = [NSNumber numberWithFloat:0];
    rotation5.duration = 0.75f;
    rotation5.repeatCount = 15;
    rotation5.speed = .33;
    [self.radarImage5.layer addAnimation:rotation5 forKey:@"360"];
}

- (void)initializeLatitudeLongitude {
    latLongTextTimer = [NSTimer scheduledTimerWithTimeInterval:.25f
                                     target:self
                                   selector:@selector(setData)
                                   userInfo:nil
                                    repeats:YES];
}

-(int) getRandomNumberBetweenMin:(int)min andMax:(int)max {
	return ((arc4random() % (max-min+1)) + min);
}

- (void)setData {
    self.latitudeLabel.text = [NSString stringWithFormat:@"%d,%d", [self getRandomNumberBetweenMin:-90 andMax:90], [self getRandomNumberBetweenMin:1000 andMax:9999]];
    self.longitudeLabel.text = [NSString stringWithFormat:@"%d,%d", [self getRandomNumberBetweenMin:-180 andMax:180], [self getRandomNumberBetweenMin:1000 andMax:9999]];
}

- (void)stopAnimations {
    [self.radarImage1.layer removeAnimationForKey:@"360"];
    [self.radarImage2.layer removeAnimationForKey:@"360"];
    [self.radarImage3.layer removeAnimationForKey:@"360"];
    [self.radarImage4.layer removeAnimationForKey:@"360"];
    [self.radarImage5.layer removeAnimationForKey:@"360"];

    self.latitudeLabel.text = @"00.00000";
    self.longitudeLabel.text = @"00.00000";
    
    [latLongTextTimer invalidate];
    latLongTextTimer = nil;
}

- (void)initializeNavigationBar {
    NavigationControllerStyler *styler = [[NavigationControllerStyler alloc] init];
    [styler style:self.navigationController.navigationBar andItem:self.navigationItem];
    
    // Back button text color
    NSDictionary *attr = [styler styleNavBarButtonToBlue:YES];
    [[UIBarButtonItem appearance] setTitleTextAttributes:attr forState:UIControlStateNormal];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initializeNavigationBar];
    
    [self initializeRadarAnimation];
    [self initializeLatitudeLongitude];
    
    // Initialize to NO app request default
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setBool:NO forKey:APP_REQUEST_BEING_DONE];
    [defaults synchronize];
    
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
    AppOrderedList *oldList = self.model.appList;
    self.model.appList = [[AppOrderedList alloc] init];
    for (int i=0; i < list_length; i++) {
        [self.model.appList.getArray addObject:[oldList objectAtIndex:i]];
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
    } else if(self.model.appList.getArray.count == 0) {
        [self.table setTableFooterView:nil];
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

// Error loading user data
- (void)userDataLoadingError {
    [self stopAnimatingRadar];
    
    [self.table setTableFooterView:nil];
    
    self.model.appList = [[AppOrderedList alloc] init];
    [self appsDataParsedFromServer];
}

#pragma mark -
#pragma mark Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSInteger sizeOfList = self.model.appList.getArray.count;
    if (sizeOfList == 0) {
        return 1;
    } else {
        return sizeOfList;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *simpleTableIdentifier = @"AppTableItem";
    static NSString *emtpyTableIdentifier = @"AppEmtpyTableItem";
    
    if (self.model.appList.getArray.count > 0) {
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
    else {
        
        CGRect bounds = [[UIScreen mainScreen] bounds];
        if (bounds.size.height == 480) {
            EmptyCell4 *cell = [tableView dequeueReusableCellWithIdentifier:emtpyTableIdentifier];
            if (cell == nil) {
                NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"EmptyCell4" owner:self options:nil];
                cell = [nib objectAtIndex:0];
                
                [cell load];
            }
            return cell;
        }
        else {
            EmptyCell *cell = [tableView dequeueReusableCellWithIdentifier:emtpyTableIdentifier];
            if (cell == nil) {
                NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"EmptyCell" owner:self options:nil];
                cell = [nib objectAtIndex:0];
                
                [cell load];
            }
            return cell;
        }
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.model.appList.getArray.count > 0) {
        return CELL_HEIGHT;
    }
    else {
        CGRect bounds = [[UIScreen mainScreen] bounds];
        if (bounds.size.height == 480) {
            return CELL_EMPTY_HEIGHT_4;
        }
        else {
            return CELL_EMPTY_HEIGHT;
        }
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.model.appList.getArray.count > 0) {
        AppDetailViewController *appViewController = [[AppDetailViewController alloc] initWithApp:[self.model.appList objectAtIndex:indexPath.row] user:self.model.user model:self.model andLocation:self.model.currentLocation];
        [self.navigationController pushViewController:appViewController animated:YES];
    }
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
        [self requestMoreAppsAndRestartList:NO];
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

- (void)requestMoreAppsAndRestartList:(BOOL)restart {
    Environment *environment = [Environment sharedInstance];
    AbstractUrlAddresses *urlAdresses = [environment addresses];
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    handler = [[AppGetterResponseHandler alloc] initWithModel:self.model mainController:self reverseGeocoder:geocoder location:self.model.location firstRequest:NO];
    
    appGetterConnector = [[AppGetterConnector alloc] initWithAddresses:urlAdresses responseHandler:handler];
    [appGetterConnector requestWithModel:self.model andLocation:self.model.location resetPagination:restart];
}

- (void)appsPaginationRequestOk {
    [self appsDataParsedFromServer];
}

- (void)appsPaginationRequestNok {
    [self appsDataParsedFromServer];
    
    _moreData = NO;
    
    [self stopAnimatingRadar];
    [self.table setTableFooterView:nil];
}

// Apps response failed
- (void)appsDataError {
    [self stopAnimatingRadar];
    
    [self.table setTableFooterView:nil];
    
    [self appsDataParsedFromServer];
}

- (void)animateRadar {
    CABasicAnimation *fullRotation;
    fullRotation = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
    fullRotation.fromValue = [NSNumber numberWithFloat:0];
    fullRotation.toValue = [NSNumber numberWithFloat:((360 * M_PI) / 180)];
    fullRotation.duration = 0.75f;
    fullRotation.repeatCount = 20;
    
    [self.loading.layer addAnimation:fullRotation forKey:@"360"];
}

- (void)stopAnimatingRadar {
    [self.loading.layer removeAnimationForKey:@"360"];
}

@end
