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
    
//    JSONToCommentMapper *commentMapper = [[JSONToCommentMapper alloc] init];
//    JSONToPhotoMapper *photoMapper = [[JSONToPhotoMapper alloc] init];
    
	NSArray *mappingProperties = [[NSArray alloc] initWithObjects:
                                  [[KeyValueScappedMapper alloc] initWithKey:@"id" action:@selector(setAppId:)],
                                  [[KeyValueScappedMapper alloc] initWithKey:@"n" action:@selector(setName:)],
                                  [[KeyValueScappedMapper alloc] initWithKey:@"i" action:@selector(setAppLogo:)],
                                  [[KeyValueScappedMapper alloc] initWithKey:@"sc" action:@selector(setAppUrlScheme:)],
                                  
//								  [[KeyValueScappedMapper alloc] initWithKey:@"IDLocalization" action:@selector(setAppId:)],
//                                  [[KeyValueScappedMapper alloc] initWithKey:@"Name" action:@selector(setName:)],
//                                  [[KeyValueMapper alloc] initWithKey:@"Latitude" action:@selector(setLatitude:)],
//                                  [[KeyValueMapper alloc] initWithKey:@"Longitude" action:@selector(setLongitude:)],
                                  [[KeyValueScappedMapper alloc] initWithKey:@"type" action:@selector(setType:)],
//
//                                  [[KeyValueScappedMapper alloc] initWithKey:@"AppName" action:@selector(setAppName:)],
//                                  [[KeyValueMapper alloc] initWithKey:@"AppLogo" action:@selector(setAppLogo:)],
//                                  [[KeyValueMapper alloc] initWithKey:@"AppLogoMini" action:@selector(setAppLogoMini:)],
//                                  [[KeyValueMapper alloc] initWithKey:@"AppURL" action:@selector(setAppUrl:)],
//                                  [[KeyValueScappedMapper alloc] initWithKey:@"AppDescription" action:@selector(setAppDescription:)],
//                                  [[KeyValueMapper alloc] initWithKey:@"Phone" action:@selector(setPhone:)],
//
                                  [[KeyValueScappedMapper alloc] initWithKey:@"pin" action:@selector(setAuxPin:)],
//                                  [[KeyValueScappedMapper alloc] initWithKey:@"AuxBlock" action:@selector(setAuxBlocked:)],
//                                  [[KeyValueMapper alloc] initWithKey:@"AuxRate" action:@selector(setAuxRate:)],
//                                  [[KeyValueMapper alloc] initWithKey:@"AuxComment" action:@selector(setAuxComment:)],
//                                  [[KeyValueMapper alloc] initWithKey:@"AuxTotalRate" action:@selector(setAuxTotalRate:)],
                                  [[KeyValueMapper alloc] initWithKey:@"tpin" action:@selector(setAuxTotalPins:)],
//                                  [[KeyValueMapper alloc] initWithKey:@"AuxTotalComments" action:@selector(setAuxTotalComments:)],
//                                  
//                                  [[TargetIteratingMapper alloc] initWithArrayKey:@"AuxComments" elementMapper:commentMapper action:@selector(setAuxCommentsArray:)],
//                                  [[TargetIteratingMapper alloc] initWithArrayKey:@"AuxPhotos" elementMapper:photoMapper action:@selector(setAuxPhotosArray:)],
//
                                  [[KeyValueMapper alloc] initWithKey:@"pr" action:@selector(setAppPrice:)],
                                  [[KeyValueScappedMapper alloc] initWithKey:@"st" action:@selector(setMarket:)],
                                  [[KeyValueScappedMapper alloc] initWithKey:@"cu" action:@selector(setCurrencyCode:)],
//                                  [[KeyValueMapper alloc] initWithKey:@"AuxNews" action:@selector(setNotificationRaw:)],
//                                  
//                                  [[KeyValueMapper alloc] initWithKey:@"la" action:@selector(setPinnedLatitude:)],
//                                  [[KeyValueMapper alloc] initWithKey:@"lo" action:@selector(setPinnedLongitude:)],
                                  
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
