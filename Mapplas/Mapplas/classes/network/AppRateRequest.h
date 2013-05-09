//
//  AppRateRequest.h
//  Mapplas
//
//  Created by Belén  on 05/02/13.
//  Copyright (c) 2013 Mapplas. All rights reserved.
//

#import "RateConnector.h"
#import "Environment.h"

@interface AppRateRequest : NSObject {
    RateConnector *connector;
}

- (void)doRequestWithRate:(NSString *)rate comment:(NSString *)comment appId:(NSString *)app_id userId:(NSNumber *)user_id location:(NSString *)c_location descriptiveGeoloc:(NSString *)descr_geoloc andViewToShowToast:(UIView *)view;

@end
