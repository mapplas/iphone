//
//  App.h
//  Mapplas
//
//  Created by Belén  on 17/01/13.
//  Copyright (c) 2013 Mapplas. All rights reserved.
//

#import "LocationCurrency.h"

@interface App : NSObject {
    NSString *_appId;
    NSString *_name;
    NSNumber *_latitude;
    NSNumber *_longitude;
    NSString *_type;
    NSString *_appUrlScheme;
    
    NSString *_appName;
    NSString *_appLogo;
    NSString *_appLogoMini;
    NSString *_appUrl;
    NSString *_appDescription;
    NSString *_phone;
    NSString *_appPrice;
    
    NSNumber *_auxPin;
    NSString *_auxBlocked;
    NSNumber *_auxRate;
    NSString *_auxComment;
    NSNumber *_auxTotalRate;
    NSNumber *_auxTotalPins;
    NSNumber *_auxTotalComments;
    
    NSMutableArray *_auxCommentsArray;
    NSMutableArray *_auxPhotosArray;
    // ApplicationInfo internalApplicationInfo = null;
    
    NSNumber *_pinnedLatitude;
    NSNumber *_pinnedLongitude;
    NSString *_pinnedGeocodedLocation;
    
    LocationCurrency *_locationCurrency;
    NSString *_market;
    
    NSArray *_notificationRaw;
}

- (id)init;

@property (nonatomic, strong) NSString *appId;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSNumber *latitude;
@property (nonatomic, strong) NSNumber *longitude;
@property (nonatomic, strong) NSString *type;
@property (nonatomic, strong) NSString *appUrlScheme;

@property (nonatomic, strong) NSString *appName;
@property (nonatomic, strong) NSString *appLogo;
@property (nonatomic, strong) NSString *appLogoMini;
@property (nonatomic, strong) NSString *appUrl;
@property (nonatomic, strong) NSString *appDescription;
@property (nonatomic, strong) NSString *phone;
@property (nonatomic, strong) NSString *appPrice;

@property (nonatomic, strong) NSNumber *auxPin;
@property (nonatomic, strong) NSString *auxBlocked;
@property (nonatomic, strong) NSNumber *auxRate;
@property (nonatomic, strong) NSString *auxComment;
@property (nonatomic, strong) NSNumber *auxTotalRate;
@property (nonatomic, strong) NSNumber *auxTotalPins;
@property (nonatomic, strong) NSNumber *auxTotalComments;

@property (nonatomic, strong) NSMutableArray *auxCommentsArray;
@property (nonatomic, strong) NSMutableArray *auxPhotosArray;
//@property (nonatomic, strong) NSNumber *appId;

@property (nonatomic, strong) NSNumber *pinnedLatitude;
@property (nonatomic, strong) NSNumber *pinnedLongitude;
@property (nonatomic, strong) NSString *pinnedGeocodedLocation;

@property (nonatomic) LocationCurrency *locationCurrency;
@property (nonatomic, strong) NSString *market;

@property (nonatomic, strong) NSArray *notificationRaw;

@end
