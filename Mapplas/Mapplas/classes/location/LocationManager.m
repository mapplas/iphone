//
//  LocationManager.m
//  Mapplas
//
//  Created by Belén  on 18/01/13.
//  Copyright (c) 2013 Mapplas. All rights reserved.
//

#import "LocationManager.h"

static CLLocationDistance distanceFilter;
static CLLocationAccuracy desiredAccuracy;
static NSTimeInterval timeOut;
static NSTimeInterval validCacheTime;

@implementation LocationManager

@synthesize manager;
@synthesize listener;
@synthesize timer;
@synthesize bestLocation = _bestLocation;
@synthesize gotLocation = _gotLocation;

+ (void)initialize {
	distanceFilter = kCLDistanceFilterNone;
    
	desiredAccuracy = 20000; //Meters
	timeOut = 10.0; //Seconds
	validCacheTime = 10.0; //Seconds. Cached locations older than validCacheTime seconds are not accepted
}

- (id)initWithLocationManager:(CLLocationManager *)locationManager managerConfigurator:(CoreLocationManagerConfigurator *)manager_configurator listener:(id<LocationListener>)location_listener {
    self = [super init];
    if (self) {
        [self setListener:location_listener];
		
		managerInitialized = NO;
		configurator = manager_configurator;
		[self setManager:locationManager];
		
		self.bestLocation = nil;
    }
    return self;
}

#pragma mark - Timer callback

- (void)searchDidTimeout {
	[self stopLocationNotifications];
	
	if (self.bestLocation != nil) { // If we had a best location saved, pass it
		[listener locationFound:self.bestLocation];
	}
	else {
		[listener locationSearchDidTimeout];
	}
}

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation {
    if (!self.gotLocation) { // only do it if we dont have a location yet
			
        self.gotLocation = YES;
        [self stopLocationNotifications];
        [listener locationFound:newLocation];
    }
    // else if already got location, do nothing
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    [self stopLocationNotifications];
    [listener locationSearchDidTimeout];
}

- (void)resetState {
	[[self manager] stopUpdatingLocation];
	if ([self timer] != nil) {
		[[self timer] invalidate]; //Stop timer
	}
	self.bestLocation = nil;
}

#pragma mark - Start/Stop location service
- (void)startLocationNotifications {
	[self resetState];
	self.gotLocation = NO;
    
	// Start timer for timeout
	[self setTimer:[NSTimer scheduledTimerWithTimeInterval:timeOut target:self selector:@selector(searchDidTimeout) userInfo:nil repeats:NO]];
    
	[[self manager] startUpdatingLocation];
}

- (void)stopLocationNotifications {
    [self resetState];
}

- (CLLocationManager *)manager {
	if (!managerInitialized) {
		managerInitialized = YES;
		manager = [manager init];
		[configurator configure:manager withDelegate:self distanceFilter:[NSNumber numberWithDouble:distanceFilter] accuracy:[NSNumber numberWithDouble:desiredAccuracy]];
	}
	return manager;
}

@end
