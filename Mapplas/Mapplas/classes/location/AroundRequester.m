//
//  AroundRequester.m
//  Mapplas
//
//  Created by Belén  on 18/01/13.
//  Copyright (c) 2013 Mapplas. All rights reserved.
//

#import "AroundRequester.h"

@implementation AroundRequester

- (id)initWithLocationManager:(LocationManager *)location_manager {
    self = [super init];
    if (self) {
        locationManager = location_manager;
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
    // MAKE REQUEST!
    NSLog(@"LOCATION FOUND!!");
}

- (void)locationSearchDidTimeout {
    // SHOW TOAST
    NSLog(@"LOCATION DID TIMEOUT!!");
}

@end