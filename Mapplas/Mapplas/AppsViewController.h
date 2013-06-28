//
//  AppsViewController.h
//  Mapplas
//
//  Created by Belén  on 17/01/13.
//  Copyright (c) 2013 Mapplas. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import <CoreLocation/CoreLocation.h>
#import <SystemConfiguration/SystemConfiguration.h>
#import "NotificationsViewController.h"
#import "UserViewController.h"
#import "UserIdentificationRequest.h"
#import "LocationManager.h"
#import "AroundRequester.h"
#import "Reachability.h"

#import "EGORefreshTableHeaderView.h"
#import "AppCell.h"
#import "EmptyCell.h"
#import "EmptyCell4.h"
#import "AppDetailViewController.h"
#import "UIDevice+IdentifierAddition.h"
#import "NavigationControllerStyler.h"

#define CELL_HEIGHT 72;
#define CELL_EMPTY_HEIGHT 504;
#define CELL_EMPTY_HEIGHT_4 416;

@interface AppsViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, EGORefreshTableHeaderDelegate> {
    UserIdentificationRequest *_userIdentRequester;
    SuperModel *_model;
    
    AppGetterResponseHandler *handler;
    
    AppGetterConnector *appGetterConnector;
    AroundRequester *_aroundRequester;
    LocationManager *locationManager;
    
    EGORefreshTableHeaderView *_refreshHeaderView;
    BOOL _reloading;
    BOOL _moreData;
    
    UIView *_radarAnim;
    NSTimer *latLongTextTimer;
}

@property (nonatomic, strong) IBOutlet UITableView *table;
@property (nonatomic, strong) IBOutlet UIView *cellLoading;
@property (nonatomic, strong) IBOutlet UIImageView *loading;
@property (nonatomic, strong) IBOutlet UILabel *loadingText;
@property (nonatomic, strong) IBOutlet UIView *cellLoadingEmpty;

@property (nonatomic, strong) IBOutlet UIView *radarAnim;
@property (nonatomic, strong) IBOutlet UIImageView *radarImage1;
@property (nonatomic, strong) IBOutlet UIImageView *radarImage2;
@property (nonatomic, strong) IBOutlet UIImageView *radarImage3;
@property (nonatomic, strong) IBOutlet UIImageView *radarImage4;
@property (nonatomic, strong) IBOutlet UIImageView *radarImage5;
@property (nonatomic, strong) IBOutlet UILabel *latitudeLabel;
@property (nonatomic, strong) IBOutlet UILabel *longitudeLabel;

@property (nonatomic, strong) UserIdentificationRequest *userIdentRequest;
@property (nonatomic, strong) SuperModel *model;
@property (nonatomic, strong) AroundRequester *aroundRequester;

- (void)appsDataParsedFromServer;
- (void)userDataLoaded;

- (void)reloadTableDataAndScrollTop:(BOOL)scroll;
- (void)stopAnimations;

- (void)appsPaginationRequestOk;
- (void)appsPaginationRequestNok;

@end
