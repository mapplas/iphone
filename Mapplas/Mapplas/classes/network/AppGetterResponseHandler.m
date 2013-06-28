//
//  AppGetterResponseHandler.m
//  Mapplas
//
//  Created by Belén  on 22/01/13.
//  Copyright (c) 2013 Mapplas. All rights reserved.
//

#import "AppGetterResponseHandler.h"
#import "AppsViewController.h"
#import "AppDelegate.h"

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
    [self setDefaultsForAppRequest];
    
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
            [self doReverseGeocoding:lastApps.intValue];
            
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
    [self setDefaultsForAppRequest];
    
    model.appList.currentLocation = model.currentLocation;
    model.appList = [[AppOrderedList alloc] init];
    
    [self doReverseGeocoding:-1];
}

- (void)setDefaultsForAppRequest {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setBool:NO forKey:APP_REQUEST_BEING_DONE];
    [defaults synchronize];
}

#pragma mark - Reverse geocoding
- (void)doReverseGeocoding:(NSInteger)last_apps {
    [geocoder reverseGeocodeLocation:location completionHandler:^(NSArray *placemarks, NSError *error) {
        if (error){
            [model setCurrentDescriptiveGeoLoc:NSLocalizedString(@"descriptive_geoloc_error", @"Reverse geocoding error")];
            return;
        }
        
        if(placemarks && placemarks.count > 0) {
            //do something
            CLPlacemark *topResult = [placemarks objectAtIndex:0];

            NSString *addressTxt = @"";
            addressTxt = [self addString:[topResult subThoroughfare] toString:addressTxt withComa:NO];
            addressTxt = [self addString:[topResult thoroughfare] toString:addressTxt withComa:NO];
            addressTxt = [self addString:[topResult locality] toString:addressTxt withComa:YES];
            
            [model setCurrentDescriptiveGeoLoc:addressTxt];
            
            if (last_apps == 0) {
                [mainController appsPaginationRequestOk];
            } else if(last_apps == -1) {
                [mainController appsDataError];
            } else {
                [mainController appsPaginationRequestNok];
            }
        }
    }];
}

- (NSString *)addString:(NSString *)str_to_add toString:(NSString *)main_str withComa:(BOOL)coma {
    if (![str_to_add isEqualToString:@""] && ![str_to_add isEqualToString:@"(null)"] && str_to_add != nil) {
        if (coma && ![main_str isEqualToString:@""]) {
            main_str = [NSString stringWithFormat:@"%@, %@", main_str, str_to_add];
        }
        else {
            main_str = [NSString stringWithFormat:@"%@ %@", main_str, str_to_add];
        }
    }
    return main_str;
}

@end
