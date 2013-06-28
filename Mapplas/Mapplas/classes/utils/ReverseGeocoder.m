//
//  ReverseGeocoder.m
//  Mapplas
//
//  Created by Belén  on 26/06/13.
//  Copyright (c) 2013 Mapplas. All rights reserved.
//

#import "ReverseGeocoder.h"

@implementation ReverseGeocoder

- (id)init {
    self = [super init];
    if (self) {
        geocoder = [[CLGeocoder alloc] init];
    }
    return self;
}

- (void)doReverseGeocodingFromLat:(NSString *)lat andLong:(NSString *)lon handler:(id<ReverseGeocoderHandler>)handler {
    
    CLLocationDegrees lat_degrees = [lat floatValue];
    CLLocationDegrees lon_degrees = [lon floatValue];
    CLLocation *location = [[CLLocation alloc] initWithLatitude:lat_degrees longitude:lon_degrees];
    
    [geocoder reverseGeocodeLocation:location completionHandler:^(NSArray *placemarks, NSError *error) {
        if (error){
            [handler geocodedNOK];
            return;
        }
        
        if(placemarks && placemarks.count > 0) {
            //do something
            CLPlacemark *topResult = [placemarks objectAtIndex:0];
            
            NSString *addressTxt = @"";
            addressTxt = [self addString:[topResult subThoroughfare] toString:addressTxt withComa:NO];
            addressTxt = [self addString:[topResult thoroughfare] toString:addressTxt withComa:NO];
            addressTxt = [self addString:[topResult locality] toString:addressTxt withComa:YES];
            
            [handler geocodedOK:addressTxt];
        }
    }];
}

- (NSString *)addString:(NSString *)str_to_add toString:(NSString *)main_str withComa:(BOOL)coma {
    if (![str_to_add isEqualToString:@""] && ![str_to_add isEqualToString:@"(null)"] && str_to_add != nil) {
        if (coma && ![main_str isEqualToString:@""]) {
            if ([main_str isEqualToString:@""]) {
                main_str = str_to_add;
            } else {
                main_str = [NSString stringWithFormat:@"%@, %@", main_str, str_to_add];
            }
        }
        else {
            if ([main_str isEqualToString:@""]) {
                main_str = str_to_add;
            } else {
                main_str = [NSString stringWithFormat:@"%@ %@", main_str, str_to_add];
            }
        }
    }
    return main_str;
}

@end
