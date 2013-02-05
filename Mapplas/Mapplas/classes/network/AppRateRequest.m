//
//  AppRateRequest.m
//  Mapplas
//
//  Created by Belén  on 05/02/13.
//  Copyright (c) 2013 Mapplas. All rights reserved.
//

#import "AppRateRequest.h"

@implementation AppRateRequest

- (void)doRequestWithRate:(NSString *)rate comment:(NSString *)comment appId:(NSString *)app_id userId:(NSString *)user_id location:(NSString *)c_location descriptiveGeoloc:(NSString *)descr_geoloc andViewToShowToast:(UIView *)view {
    
    Environment *environment = [Environment sharedInstance];
	AbstractUrlAddresses *urlAdresses = [environment addresses];
    AppRateRequestResponseHandler *handler = [[AppRateRequestResponseHandler alloc] initWithView:view];
    
    connector = [[RateConnector alloc] initWithAddresses:urlAdresses andHandler:handler];
    [connector requestWithRate:rate comment:comment appId:app_id userId:user_id location:c_location andDescriptiveGeoloc:descr_geoloc];
}

@end
