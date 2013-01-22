//
//  AroundRequester.h
//  Mapplas
//
//  Created by Belén  on 18/01/13.
//  Copyright (c) 2013 Mapplas. All rights reserved.
//

#import "LocationListener.h"
#import "LocationManager.h"

@interface AroundRequester : NSObject <LocationListener> {
	LocationManager *locationManager;
}

- (id)initWithLocationManager:(LocationManager *)location_manager;

- (void)startRequesting;
- (void)stop;

@end


