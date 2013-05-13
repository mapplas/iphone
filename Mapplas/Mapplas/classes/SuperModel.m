//
//  SuperModel.m
//  Mapplas
//
//  Created by Belén  on 17/01/13.
//  Copyright (c) 2013 Mapplas. All rights reserved.
//

#import "SuperModel.h"

@implementation SuperModel

@synthesize currentLocation = _currentLocation;
@synthesize location = _location;
@synthesize user = _user;
@synthesize currentRadius = _currentRadius;
@synthesize currentImei = _currentImei;
@synthesize currentDescriptiveGeoLoc = _currentDescriptiveGeoLoc;
@synthesize appList = _appList;
@synthesize notificationList = _notificationList;
@synthesize operationError = _operationError;
@synthesize errorText = _errorText;
@synthesize notificationRawList = _notificationRawList;

- (id)init {
    self = [super init];
    if (self) {
        self.currentLocation = @"";
        self.location = nil;
        self.user = nil;
        self.currentRadius = @"0.1";
        self.currentImei = @"";
        self.currentDescriptiveGeoLoc = @"";
        self.appList = [[AppOrderedList alloc] init];
        self.notificationList = [[NotificationList alloc] init];
        self.operationError = NO;
        self.errorText = @"";
        self.notificationRawList = nil;
    }
    return self;
}

@end
