//
//  AppsViewController.h
//  Mapplas
//
//  Created by Belén  on 17/01/13.
//  Copyright (c) 2013 Mapplas. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import "NotificationsViewController.h"
#import "UserViewController.h"
#import "UserIdentificationRequest.h"
#import "LocationManager.h"
#import "AroundRequester.h"

#import "EGORefreshTableHeaderView.h"
#import "AppCell.h"
#import "InfiniteScrollManager.h"
#import "AppDetailViewController.h"

@interface AppsViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, EGORefreshTableHeaderDelegate> {
    UserIdentificationRequest *_userIdentRequester;
    SuperModel *_model;
    
    NSMutableArray *_loadedAppsArray;
    NSUInteger _loadedListCount;
    InfiniteScrollManager *scrollManager;
    
    AroundRequester *_aroundRequester;
    LocationManager *locationManager;
    
    EGORefreshTableHeaderView *_refreshHeaderView;
    BOOL _reloading;
}

@property (nonatomic, strong) IBOutlet UITableView *table;
@property (nonatomic, strong) IBOutlet UIView *cellLoading;
@property (nonatomic, strong) IBOutlet UIImageView *loading;
@property (nonatomic, strong) IBOutlet UILabel *loadingText;
@property (nonatomic, strong) NSMutableArray *loadedAppsArray;
@property (nonatomic) NSUInteger loadedListCount;

@property (nonatomic, strong) UserIdentificationRequest *userIdentRequest;
@property (nonatomic, strong) SuperModel *model;
@property (nonatomic, strong) AroundRequester *aroundRequester;

- (void)appsDataParsedFromServer;
- (void)userDataLoaded;

- (void) addItemsToEndOfTableView;

- (void)reloadTableDataAndScrollTop:(BOOL)scroll;

@end
