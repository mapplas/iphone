//
//  JSONToAppMapper.m
//  Mapplas
//
//  Created by Belén  on 23/01/13.
//  Copyright (c) 2013 Mapplas. All rights reserved.
//

#import "JSONToAppMapper.h"

@implementation JSONToAppMapper

- (id)init {
    
	NSArray *mappingProperties = [[NSArray alloc] initWithObjects:
                                  [[KeyValueScappedMapper alloc] initWithKey:@"id" action:@selector(setAppId:)],
                                  [[KeyValueScappedMapper alloc] initWithKey:@"n" action:@selector(setName:)],
                                  [[KeyValueScappedMapper alloc] initWithKey:@"i" action:@selector(setAppLogo:)],
                                  [[KeyValueScappedMapper alloc] initWithKey:@"sc" action:@selector(setAppUrlScheme:)],
                                  [[KeyValueMapper alloc] initWithKey:@"asid" action:@selector(setAppAppStoreId:)],
                                  
                                  [[KeyValueScappedMapper alloc] initWithKey:@"type" action:@selector(setType:)],

                                  [[KeyValueScappedMapper alloc] initWithKey:@"pin" action:@selector(setAuxPin:)],
                                  [[KeyValueMapper alloc] initWithKey:@"tpin" action:@selector(setAuxTotalPins:)],

                                  [[KeyValueMapper alloc] initWithKey:@"pr" action:@selector(setAppPrice:)],
                                  [[KeyValueScappedMapper alloc] initWithKey:@"st" action:@selector(setMarket:)],
                                  [[KeyValueScappedMapper alloc] initWithKey:@"cu" action:@selector(setCurrencyCode:)],
                                  
                                  nil];
    
    self = [super initWithMappers:mappingProperties];
    
    return self;
}

- (App *)map:(NSDictionary *)json {
    App *app = [[App alloc] init];
    
    [super map:json target:app];
    
//    if ([[app market] isEqualToString:@"Usa"]) {
//        [app setLocationCurrency:DOLLAR];
//    }
//    else {
//        [app setLocationCurrency:EURO];
//    }
    
//    if (app.pinnedLatitude != nil && app.pinnedLongitude != nil) {
//        CLLocationDegrees latitudeDeg = (CLLocationDegrees)[app.latitude doubleValue];
//        CLLocationDegrees longitudeDeg = (CLLocationDegrees)[app.longitude doubleValue];
//        CLLocation *appPinnedLocation = [[CLLocation alloc] initWithLatitude:latitudeDeg longitude:longitudeDeg];
//        
//        [geocoder reverseGeocodeLocation:appPinnedLocation completionHandler:^(NSArray *placemarks, NSError *error) {
//            if (error){
//                [app setPinnedGeocodedLocation:NSLocalizedString(@"descriptive_geoloc_error", @"Reverse geocoding error")];
//                return;
//            }
//            
//            if(placemarks && placemarks.count > 0) {
//                //do something
//                CLPlacemark *topResult = [placemarks objectAtIndex:0];
//                //            NSString *sub = [topResult subThoroughfare];
//                //            NSString *thr = [topResult thoroughfare];
//                //            NSString *local = [topResult locality];
//                NSString *addressTxt = [NSString stringWithFormat:@"%@ %@, %@",
//                                        [topResult subThoroughfare],[topResult thoroughfare],
//                                        [topResult locality]];
//                
//                [app setPinnedGeocodedLocation:addressTxt];
//            }
//        }];
//    }
    
    return app;
}

@end
