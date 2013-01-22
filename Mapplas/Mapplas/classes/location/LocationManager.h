//
//  LocationManager.h
//  Mapplas
//
//  Created by Belén  on 18/01/13.
//  Copyright (c) 2013 Mapplas. All rights reserved.
//

#import <CoreLocation/CoreLocation.h>
#import "LocationListener.h"
#import "CoreLocationManagerConfigurator.h"

@interface LocationManager : NSObject <CLLocationManagerDelegate> {
    CLLocationManager *manager;
	id<LocationListener> listener;
	NSTimer *timer;
	BOOL _gotLocation;
	BOOL managerInitialized;
	CoreLocationManagerConfigurator *configurator;
	CLLocation *_bestLocation;
}

@property (nonatomic, strong) CLLocationManager *manager;
@property (nonatomic, strong) id<LocationListener> listener;
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, strong) CLLocation *bestLocation;
@property (atomic, assign) BOOL gotLocation;

-(id)initWithLocationManager:(CLLocationManager *)locationManager managerConfigurator:(CoreLocationManagerConfigurator *)manager_configurator listener:(id<LocationListener>)location_listener;

-(void)startLocationNotifications;
-(void)stopLocationNotifications;

@end
