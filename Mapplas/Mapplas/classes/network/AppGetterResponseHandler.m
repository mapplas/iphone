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

- (id)initWithModel:(SuperModel *)_model mainController:(AppsViewController *)main_controller reverseGeocoder:(CLGeocoder *)_geocoder location:(CLLocation *)_location {
    self = [super init];
    if (self) {
        model = _model;
        mainController = main_controller;
        geocoder = _geocoder;
        location = _location;
    }
    return self;
}
- (void)requestFinished:(id)JSON {
    // Parse apps
    NSArray *jsonObjects = JSON;
    JSONToAppMapper *appMapper = [[JSONToAppMapper alloc] init];
    
    App *app = nil;
    AppOrderedList *list = [[AppOrderedList alloc] init];
    for (int i=0; i < jsonObjects.count; i++) {
        app = [appMapper map:[jsonObjects objectAtIndex:i]];
        [list addObject:app];
    }
    
    [model setAppList:list];
    model.appList.currentLocation = model.currentLocation;
    [model.appList sort];
    
    // Do reverse geocoding
    [self doReverseGeocoding];
    
    // Notification DB inserter
    NotificationDBInserter *dbInserter = [[NotificationDBInserter alloc] initWithModel:model viewController:mainController];
    [dbInserter insertNotificationsToDB];
    
    // App info sender
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
