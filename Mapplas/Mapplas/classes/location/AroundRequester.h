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

@interface AroundRequester : NSObject <LocationListener> {
	LocationManager *locationManager;
    SuperModel *model;
    AppGetterConnector *connector;
}

- (id)initWithLocationManager:(LocationManager *)location_manager andModel:(SuperModel *)s_model;

- (void)startRequesting;
- (void)stop;

@end


