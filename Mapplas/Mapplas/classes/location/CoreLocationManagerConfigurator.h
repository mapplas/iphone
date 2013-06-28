//
//  CoreLocationManagerConfigurator.h
//  Mapplas
//
//  Created by Belén  on 18/01/13.
//  Copyright (c) 2013 Mapplas. All rights reserved.
//

#import <CoreLocation/CoreLocation.h>

@interface CoreLocationManagerConfigurator : NSObject

- (void)configure:(CLLocationManager *)manager withDelegate:(id<CLLocationManagerDelegate>)delegate distanceFilter:(NSNumber *)filter accuracy:(NSNumber *)accuracy;

@end
