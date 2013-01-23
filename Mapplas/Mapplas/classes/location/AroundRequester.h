//
//  AroundRequester.h
//  Mapplas
//
//  Created by Belén  on 18/01/13.
//  Copyright (c) 2013 Mapplas. All rights reserved.
//

#import "LocationListener.h"
#import "LocationManager.h"
#import "AppGetterConnector.h"
#import "Environment.h"

@class AppsViewController;

@interface AroundRequester : NSObject <LocationListener> {
	LocationManager *locationManager;
    SuperModel *model;
    AppGetterConnector *connector;
    AppGetterResponseHandler *handler;
    AppsViewController *viewController;
}

- (id)initWithLocationManager:(LocationManager *)location_manager model:(SuperModel *)s_model mainViewController:(AppsViewController *)main_controller;

- (void)startRequesting;
- (void)stop;

@end


