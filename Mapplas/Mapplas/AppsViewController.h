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

@interface AppsViewController : UIViewController {
    UserIdentificationRequest *_userIdentRequester;
    SuperModel *_model;
    
    AroundRequester *_aroundRequester;
}

@property (nonatomic, strong) UserIdentificationRequest *userIdentRequest;
@property (nonatomic, strong) SuperModel *model;
@property (nonatomic, strong) AroundRequester *aroundRequester;


@end
