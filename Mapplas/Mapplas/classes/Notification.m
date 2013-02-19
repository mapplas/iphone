//
//  Notification.m
//  Mapplas
//
//  Created by Belén  on 12/02/13.
//  Copyright (c) 2013 Mapplas. All rights reserved.
//

#import "Notification.h"

@implementation Notification

@synthesize uniqueIdentifier = _uniqueIdentifier;
@synthesize companyId = _companyId;
@synthesize appId = _appId;
@synthesize name = _name;
@synthesize description = _description;
@synthesize date = _date;
@synthesize hour = _hour;
@synthesize auxApp = _auxApp;
@synthesize seen = _seen;
@synthesize shown = _shown;
@synthesize arrivalTimestamp = _arrivalTimestamp;
@synthesize currentLocation = _currentLocation;
@synthesize dateInMs = _dateInMs;

- (id)init {
    self = [super init];
    if (self) {
        self.uniqueIdentifier = @"";
        self.companyId = @"0";
        self.appId = @"0";
        self.name = @"";
        self.description = @"";
        self.date = @"";
        self.hour = @"";
        self.auxApp = nil;
        self.seen = 0;
        self.shown = 0;
        self.arrivalTimestamp = [NSNumber numberWithInt:0];;
        self.currentLocation = @"";
        self.dateInMs = [NSNumber numberWithInt:0];
    }
    return self;
}

@end
