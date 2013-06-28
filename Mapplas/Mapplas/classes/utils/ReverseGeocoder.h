//
//  ReverseGeocoder.h
//  Mapplas
//
//  Created by Belén  on 26/06/13.
//  Copyright (c) 2013 Mapplas. All rights reserved.
//

#import <MapKit/MapKit.h>
#import "ReverseGeocoderHandler.h"

@interface ReverseGeocoder : NSObject {
    CLGeocoder *geocoder;
}

- (void)doReverseGeocodingFromLat:(NSString *)lat andLong:(NSString *)lon handler:(id<ReverseGeocoderHandler>)handler;

@end
