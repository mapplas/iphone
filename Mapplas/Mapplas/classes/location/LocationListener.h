//
//  LocationListener.h
//  Mapplas
//
//  Created by Belén  on 18/01/13.
//  Copyright (c) 2013 Mapplas. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@protocol LocationListener <NSObject>

@required
- (void)locationFound:(CLLocation *)location;

@optional
- (void)locationSearchDidTimeout;

@end
