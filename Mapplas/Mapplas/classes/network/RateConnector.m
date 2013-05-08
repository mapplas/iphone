//
//  RateConnector.m
//  Mapplas
//
//  Created by Belén  on 05/02/13.
//  Copyright (c) 2013 Mapplas. All rights reserved.
//

#import "RateConnector.h"

@implementation RateConnector

- (id)initWithAddresses:(AbstractUrlAddresses *)_addresses andHandler:(AppRateRequestResponseHandler *)handler {
    return [super initWithAddresses:_addresses responseHandler:handler];
}

- (void)requestWithRate:(NSString *)rate comment:(NSString *)comment appId:(NSString *)app_id userId:(NSNumber *)user_id location:(NSString *)c_location andDescriptiveGeoloc:(NSString *)descr_geoloc {
    
    [parameters setValue:rate forKey:@"r"];
    [parameters setValue:comment forKey:@"c"];
    [parameters setValue:app_id forKey:@"id"];
    [parameters setValue:user_id forKey:@"uid"];
    [parameters setValue:c_location forKey:@"l"];
    [parameters setValue:descr_geoloc forKey:@"dl"];
    
    [super initializeVariablesWithUrlAndSend:[self getUrl]];
}

- (NSString *)getUrl {
    return [adresses rateApp];
}

@end
