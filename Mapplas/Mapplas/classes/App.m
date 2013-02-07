//
//  App.m
//  Mapplas
//
//  Created by Belén  on 17/01/13.
//  Copyright (c) 2013 Mapplas. All rights reserved.
//

#import "App.h"

@implementation App

@synthesize appId = _appId;
@synthesize name = _name;
@synthesize latitude = _latitude;
@synthesize longitude = _longitude;
@synthesize type = _type;

@synthesize appName = _appName;
@synthesize appLogo = _appLogo;
@synthesize appLogoMini = _appLogoMini;
@synthesize appUrl = _appUrl;
@synthesize appDescription = _appDescription;
@synthesize phone = _phone;
@synthesize appPrice = _appPrice;

@synthesize auxPin = _auxPin;
@synthesize auxBlocked = _auxBlocked;
@synthesize auxRate = _auxRate;
@synthesize auxComment = _auxComment;
@synthesize auxTotalRate = _auxTotalRate;
@synthesize auxTotalPins = _auxTotalPins;
@synthesize auxTotalComments = _auxTotalComments;

@synthesize auxCommentsArray = _auxCommentsArray;
@synthesize auxPhotosArray = _auxPhotosArray;
//@synthesize

@synthesize pinnedLatitude = _pinnedLatitude;
@synthesize pinnedLongitude = _pinnedLongitude;
@synthesize setPinnedGeocodedLocation = _setPinnedGeocodedLocation;

@synthesize locationCurrency = _locationCurrency;
@synthesize market = _market;

@synthesize notificationRaw = _notificationRaw;

- (id)init {
    self = [super init];
    if (self) {
        self.appId = @"0";
        self.name = @"";
        self.latitude = [NSNumber numberWithDouble:0.0f];
        self.longitude = [NSNumber numberWithDouble:0.0f];
        self.type = @"";
        
        self.phone = @"";
        self.appPrice = @"0";
        
        self.auxPin = @"0";
        self.auxBlocked = @"0";
        self.auxRate = [NSNumber numberWithDouble:0.0f];
        self.auxTotalRate = [NSNumber numberWithDouble:0.0f];
        self.pinnedLatitude = [NSNumber numberWithDouble:0.0f];
        self.pinnedLongitude = [NSNumber numberWithDouble:0.0f];
        
        self.auxCommentsArray = [[NSMutableArray alloc] init];
        self.auxPhotosArray = [[NSMutableArray alloc] init];
        
        self.locationCurrency = EURO;
        self.market = @"Eur";
        
        self.notificationRaw = [[NSArray alloc] init];
    }
    return self;
}

@end
