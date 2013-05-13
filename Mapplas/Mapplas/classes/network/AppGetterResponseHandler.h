//
//  AppGetterResponseHandler.h
//  Mapplas
//
//  Created by Belén  on 22/01/13.
//  Copyright (c) 2013 Mapplas. All rights reserved.
//

#import <MapKit/MapKit.h>
#import "GenericRequestHandler.h"
#import "JSONToAppMapper.h"
#import "SuperModel.h"
#import "NotificationDBInserter.h"

@class AppsViewController;

@interface AppGetterResponseHandler : NSObject <GenericRequestHandler> {
    SuperModel *model;
    AppsViewController *mainController;
    CLGeocoder *geocoder;
    CLLocation *location;
    BOOL isFirstRequest;
}

- (id)initWithModel:(SuperModel *)_model mainController:(AppsViewController *)main_controller reverseGeocoder:(CLGeocoder *)_geocoder location:(CLLocation *)_location firstRequest:(BOOL)is_first_request;

@end
