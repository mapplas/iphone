//
//  AppGetterResponseHandler.m
//  Mapplas
//
//  Created by Belén  on 22/01/13.
//  Copyright (c) 2013 Mapplas. All rights reserved.
//

#import "AppGetterResponseHandler.h"
#import "AppsViewController.h"

@implementation AppGetterResponseHandler

- (id)initWithModel:(SuperModel *)_model mainController:(AppsViewController *)main_controller reverseGeocoder:(CLGeocoder *)_geocoder location:(CLLocation *)_location firstRequest:(BOOL)is_first_request {
    self = [super init];
    if (self) {
        model = _model;
        mainController = main_controller;
        geocoder = _geocoder;
        location = _location;
        isFirstRequest = is_first_request;
    }
    return self;
}
- (void)requestFinished:(id)JSON {
    // Parse apps
    NSDictionary *response = JSON;

    NSArray *jsonApps = [response objectForKey:@"apps"];
    NSNumber *lastApps = [response objectForKey:@"last"];
    
    if (isFirstRequest) {
        model.appList = [[AppOrderedList alloc] init];
    }
    
    if (jsonApps != nil && lastApps != nil) {
        JSONToAppMapper *appMapper = [[JSONToAppMapper alloc] init];
        
        App *app = nil;
        AppOrderedList *list = model.appList;
        
        for (int i=0; i < jsonApps.count; i++) {
            app = [appMapper map:[jsonApps objectAtIndex:i]];
            [list addObject:app];
        }
        
        [model setAppList:list];
        model.appList.currentLocation = model.currentLocation;
        [model.appList sort];
        
        if (isFirstRequest) {
            // Do reverse geocoding
            [self doReverseGeocoding];
            
            // App info sender - url scheme request to server and verify wit canOpenURL:
        } else {
            // Go to app screen directly. Reverse geocoding done before.
            if (lastApps.intValue == 0) {
                [mainController appsPaginationRequestOk];
            } else {
                [mainController appsPaginationRequestNok];
            }
        }
    }
}

- (void)requestFinishedWithErrors:(NSError *)error andReponse:(id)JSON {
    NSLog(@"Response delegate error, %@, %@", [error description], JSON);
}

#pragma mark - Reverse geocoding
- (void)doReverseGeocoding {    
    [geocoder reverseGeocodeLocation:location completionHandler:^(NSArray *placemarks, NSError *error) {
        if (error){
            [model setCurrentDescriptiveGeoLoc:NSLocalizedString(@"descriptive_geoloc_error", @"Reverse geocoding error")];
            return;
        }
        
        if(placemarks && placemarks.count > 0) {
            //do something
            CLPlacemark *topResult = [placemarks objectAtIndex:0];
//            NSString *sub = [topResult subThoroughfare];
//            NSString *thr = [topResult thoroughfare];
//            NSString *local = [topResult locality];
            NSString *addressTxt = [NSString stringWithFormat:@"%@ %@, %@",
                                    [topResult subThoroughfare],[topResult thoroughfare],
                                    [topResult locality]];
            
            [model setCurrentDescriptiveGeoLoc:addressTxt];
            [mainController appsDataParsedFromServer];
        }
    }];
}

@end
