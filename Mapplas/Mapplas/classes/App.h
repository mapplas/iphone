//
//  App.h
//  Mapplas
//
//  Created by Belén  on 17/01/13.
//  Copyright (c) 2013 Mapplas. All rights reserved.
//

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
    NSString *_appSupportUrl;
    NSString *_appDescription;
    NSString *_phone;
    
    NSNumber *_auxPin;
    NSString *_auxBlocked;
    NSNumber *_auxRate;
    NSString *_auxComment;
    NSNumber *_auxTotalRate;
    NSNumber *_auxTotalPins;
    NSNumber *_auxTotalComments;
    
    NSMutableArray *_auxCommentsArray;
    NSString *_auxPhotosStr;
    NSArray *_auxPhotosArray;
    // ApplicationInfo internalApplicationInfo = null;
    
    NSNumber *_pinnedLatitude;
    NSNumber *_pinnedLongitude;
    NSString *_pinnedGeocodedLocation;
    
    NSNumber *_appPrice;
    NSString *_currencyCode;
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
@property (nonatomic, strong) NSString *appSupportUrl;
@property (nonatomic, strong) NSString *appDescription;
@property (nonatomic, strong) NSString *phone;

@property (nonatomic, strong) NSNumber *auxPin;
@property (nonatomic, strong) NSString *auxBlocked;
@property (nonatomic, strong) NSNumber *auxRate;
@property (nonatomic, strong) NSString *auxComment;
@property (nonatomic, strong) NSNumber *auxTotalRate;
@property (nonatomic, strong) NSNumber *auxTotalPins;
@property (nonatomic, strong) NSNumber *auxTotalComments;

@property (nonatomic, strong) NSMutableArray *auxCommentsArray;
@property (nonatomic, strong) NSString *auxPhotosStr;
@property (nonatomic, strong) NSArray *auxPhotosArray;

@property (nonatomic, strong) NSNumber *pinnedLatitude;
@property (nonatomic, strong) NSNumber *pinnedLongitude;
@property (nonatomic, strong) NSString *pinnedGeocodedLocation;

@property (nonatomic, strong) NSNumber *appPrice;
@property (nonatomic, strong) NSString *currencyCode;
@property (nonatomic, strong) NSString *market;

@property (nonatomic, strong) NSArray *notificationRaw;

@end
