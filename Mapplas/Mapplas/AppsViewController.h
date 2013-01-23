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

@interface AppsViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, EGORefreshTableHeaderDelegate> {
    UserIdentificationRequest *_userIdentRequester;
    SuperModel *_model;
    
    AroundRequester *_aroundRequester;
    
    EGORefreshTableHeaderView *_refreshHeaderView;
    BOOL _reloading;
}

@property (nonatomic, strong) IBOutlet UITableView *table;

@property (nonatomic, strong) UserIdentificationRequest *userIdentRequest;
@property (nonatomic, strong) SuperModel *model;
@property (nonatomic, strong) AroundRequester *aroundRequester;

- (void)appsDataParsedFromServer;

@end
