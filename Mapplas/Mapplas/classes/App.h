//
//  App.h
//  Mapplas
//
//  Created by Belén  on 17/01/13.
//  Copyright (c) 2013 Mapplas. All rights reserved.
//

@interface App : NSObject {
    // App mapper
    NSString *_appId;
    NSNumber *_appAppStoreId;
    NSString *_name;
    NSString *_appLogo;
    NSString *_appUrlScheme;

    NSString *_type;
    
    NSNumber *_auxPin;
    NSNumber *_auxTotalPins;
    NSString *_appPinnedGeocodedLocation;
    
    NSNumber *_appPrice;
    NSString *_currencyCode;
    NSString *_market;

    // App detail mapper
    NSString *_appUrl;
    NSString *_appSupportUrl;
    NSString *_appDescription;

    NSString *_auxPhotosStr;
    NSArray *_auxPhotosArray;
    
    // ????
    NSNumber *_latitude;
    NSNumber *_longitude;
    NSString *_phone;
}

- (id)init;

@property (nonatomic, strong) NSString *appId;
@property (nonatomic, strong) NSNumber *appAppStoreId;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *appLogo;
@property (nonatomic, strong) NSString *appUrlScheme;

@property (nonatomic, strong) NSString *type;

@property (nonatomic, strong) NSNumber *auxPin;
@property (nonatomic, strong) NSNumber *auxTotalPins;
@property (nonatomic, strong) NSString *appPinnedGeocodedLocation;

@property (nonatomic, strong) NSNumber *appPrice;
@property (nonatomic, strong) NSString *currencyCode;
@property (nonatomic, strong) NSString *market;

@property (nonatomic, strong) NSString *appUrl;
@property (nonatomic, strong) NSString *appSupportUrl;
@property (nonatomic, strong) NSString *appDescription;

@property (nonatomic, strong) NSString *auxPhotosStr;
@property (nonatomic, strong) NSArray *auxPhotosArray;

/// ????
@property (nonatomic, strong) NSString *phone;
@property (nonatomic, strong) NSNumber *latitude;
@property (nonatomic, strong) NSNumber *longitude;

@end
