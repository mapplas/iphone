//
//  CoreLocationManagerConfigurator.m
//  Mapplas
//
//  Created by Belén  on 18/01/13.
//  Copyright (c) 2013 Mapplas. All rights reserved.
//

#import "CoreLocationManagerConfigurator.h"

@implementation CoreLocationManagerConfigurator

- (void)configure:(CLLocationManager *)manager withDelegate:(id<CLLocationManagerDelegate>)delegate distanceFilter:(NSNumber *)filter accuracy:(NSNumber *)accuracy {
    [manager setDelegate:delegate];
	[manager setDistanceFilter:[filter doubleValue]];
	[manager setDesiredAccuracy:[accuracy doubleValue]];
}

@end
