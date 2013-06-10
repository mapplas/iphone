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
    model.location = location;
    
//    // MOCKED LOCATION
//    ///////////////
//    double lat = 42.343992;
//    double lon = -3.696906;
//    
//    model.currentLocation = [NSString stringWithFormat:@"%f,%f", lat, lon];
//    
//    CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake(lat, lon);
//    
//    CLLocation *loc = [[CLLocation alloc] initWithCoordinate:coordinate altitude:0 horizontalAccuracy:0 verticalAccuracy:0 course:0 speed:0 timestamp:0];
//    model.location = loc;
//    //////////////
	
	AbstractUrlAddresses *urlAdresses = [environment addresses];
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    handler = [[AppGetterResponseHandler alloc] initWithModel:model mainController:viewController reverseGeocoder:geocoder location:model.location firstRequest:YES];
    
    appGetterConnector = [[AppGetterConnector alloc] initWithAddresses:urlAdresses responseHandler:handler];
    [appGetterConnector requestWithModel:model andLocation:model.location resetPagination:YES];
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