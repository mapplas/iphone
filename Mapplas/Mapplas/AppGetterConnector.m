//
//  AppGetterConnector.m
//  Mapplas
//
//  Created by Belén  on 22/01/13.
//  Copyright (c) 2013 Mapplas. All rights reserved.
//

#import "AppGetterConnector.h"

@implementation AppGetterConnector

- (id)initWithAddresses:(AbstractUrlAddresses *)_addresses responseHandler:(AppGetterResponseHandler *)response_handler {
    self = [super initWithAddresses:_addresses responseHandler:response_handler];
    if (self) {
        
    }
    return self;
}

- (void)requestWithModel:(SuperModel *)super_model andLocation:(CLLocation *)location {
    CLLocationCoordinate2D coord = location.coordinate;
    NSString *stringLocation = [NSString stringWithFormat:@"%g, %g", coord.latitude, coord.longitude];
    
    [parameters setValue:@"43.326426,-1.985607" forKey:@"l"];
    [parameters setValue:[[super_model user] userId] forKey:@"uid"];
    [parameters setValue:[NSString stringWithFormat:@"%f", location.horizontalAccuracy] forKey:@"p"];
    [parameters setValue:@"" forKey:@"ln"];
    
    [super initializeVariablesWithUrlAndSend:[self getUrl]];
}

- (NSString *)getUrl {
    return [adresses getApps];
}

@end
