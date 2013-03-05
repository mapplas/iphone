//
//  AroundRequester.m
//  Mapplas
//
//  Created by Belén  on 18/01/13.
//  Copyright (c) 2013 Mapplas. All rights reserved.
//

#import "AroundRequester.h"
#import "AppsViewController.h"
#import "AppDelegate.h"

@implementation AroundRequester

- (id)initWithLocationManager:(LocationManager *)location_manager model:(SuperModel *)s_model mainViewController:(AppsViewController *)main_controller {
    self = [super init];
    if (self) {
        locationManager = location_manager;
        model = s_model;
        viewController = main_controller;
        [locationManager setListener:self];
    }
    return self;
}

- (void)startRequesting {
    [locationManager startLocationNotifications];
}

- (void)stop {
    [locationManager stopLocationNotifications];
}

#pragma mark - Location listener methods

- (void)locationFound:(CLLocation *)location {    
    Environment *environment = [Environment sharedInstance];
    
    CLLocationCoordinate2D coordinate = location.coordinate;
    model.currentLocation = [NSString stringWithFormat:@"%f,%f", coordinate.latitude, coordinate.longitude];
	
	AbstractUrlAddresses *urlAdresses = [environment addresses];
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    handler = [[AppGetterResponseHandler alloc] initWithModel:model mainController:viewController reverseGeocoder:geocoder location:location];
    
    appGetterConnector = [[AppGetterConnector alloc] initWithAddresses:urlAdresses responseHandler:handler];
    [appGetterConnector requestWithModel:model andLocation:location];
}

- (void)locationSearchDidTimeout {
    [viewController stopAnimations];
    
    UIAlertView *loactionAlert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"location_error_dialog_title", @"Location not found error title") message:NSLocalizedString(@"location_error_dialog_message", @"Location not found error message") delegate:self cancelButtonTitle:NSLocalizedString(@"ok_message", @"OK message") otherButtonTitles:nil, nil];
    
    [loactionAlert show];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if ([defaults objectForKey:APP_HAS_TO_RESTART] != nil) {
        [defaults setBool:YES forKey:APP_HAS_TO_RESTART];
        [defaults synchronize];
    }
}

@end