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
@synthesize appLogo = _appLogo;
@synthesize appUrlScheme = _appUrlScheme;
@synthesize appShortDescription = _appShortDescription;

@synthesize type = _type;

@synthesize auxPin = _auxPin;
@synthesize auxTotalPins = _auxTotalPins;
@synthesize appPinnedGeocodedLocation = _appPinnedGeocodedLocation;

@synthesize appPrice = _appPrice;
@synthesize currencyCode = _currencyCode;
@synthesize market = _market;

@synthesize appUrl = _appUrl;
@synthesize appSupportUrl = _appSupportUrl;
@synthesize appDescription = _appDescription;

@synthesize auxPhotosStr = _auxPhotosStr;
@synthesize auxPhotosArray = _auxPhotosArray;

@synthesize latitude = _latitude;
@synthesize longitude = _longitude;
@synthesize phone = _phone;

- (id)init {
    self = [super init];
    if (self) {
        self.name = @"";

        self.type = @"";
        self.appUrlScheme = @"";
        self.appShortDescription = @"";
        
        self.appUrl = @"";
        self.phone = @"";
        
        self.auxPin = [NSNumber numberWithInt:0];
        
        self.auxPhotosStr = @"";
        self.auxPhotosArray = [[NSArray alloc] init];
        
    }
    return self;
}

@end
