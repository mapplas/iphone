//
//  AppShareConnector.m
//  Mapplas
//
//  Created by Belén  on 09/05/13.
//  Copyright (c) 2013 Mapplas. All rights reserved.
//

#import "AppShareConnector.h"

@implementation AppShareConnector

- (id)initWithAddresses:(AbstractUrlAddresses *)_addresses {
    return [super initWithAddresses:_addresses responseHandler:nil];
}

- (void)requestWithAppId:(NSNumber *)app_id userId:(NSNumber *)user_id andLocation:(NSString *)currentLocation via:(NSString *)_via {
    NSArray *splitedLocation = [currentLocation componentsSeparatedByString:@","];
    
    [parameters setValue:app_id forKey:@"app"];
    [parameters setValue:user_id forKey:@"uid"];
    [parameters setValue:[splitedLocation objectAtIndex:0] forKey:@"lat"];
    [parameters setValue:[splitedLocation objectAtIndex:1] forKey:@"lon"];
    [parameters setValue:_via forKey:@"via"];
    
    [super initializeVariablesWithUrlAndSend:[self getUrl]];
}

- (NSString *)getUrl {
    return [adresses shareApp];
}

@end
