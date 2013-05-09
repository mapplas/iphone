//
//  RateConnector.h
//  Mapplas
//
//  Created by Belén  on 05/02/13.
//  Copyright (c) 2013 Mapplas. All rights reserved.
//

#import "GenericConnector.h"
#import "AppRateRequestResponseHandler.h"

@interface RateConnector : GenericConnector

- (id)initWithAddresses:(AbstractUrlAddresses *)_addresses andHandler:(AppRateRequestResponseHandler *)handler;
- (void)requestWithRate:(NSString *)rate comment:(NSString *)comment appId:(NSString *)app_id userId:(NSNumber *)user_id location:(NSString *)c_location andDescriptiveGeoloc:(NSString *)descr_geoloc;

@end
