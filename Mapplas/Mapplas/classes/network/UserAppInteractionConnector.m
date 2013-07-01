//
//  UserAppInteractionConnector.m
//  Mapplas
//
//  Created by Belén  on 01/07/13.
//  Copyright (c) 2013 Mapplas. All rights reserved.
//

#import "UserAppInteractionConnector.h"

@implementation UserAppInteractionConnector

- (id)initWithAddresses:(AbstractUrlAddresses *)_addresses {
    return [super initWithAddresses:_addresses responseHandler:nil];
}

- (void)requestWithUserId:(NSString *)user_id appId:(NSString *)app_id location:(NSString *)location {
    NSArray *splitedLocation = [location componentsSeparatedByString:@","];

    [parameters setValue:user_id forKey:@"uid"];
    [parameters setValue:app_id forKey:@"app"];
    [parameters setValue:[splitedLocation objectAtIndex:0] forKey:@"lat"];
    [parameters setValue:[splitedLocation objectAtIndex:1] forKey:@"lon"];
    
    [super initializeVariablesWithUrlAndSend:[self getUrl]];
}

- (NSString *)getUrl {
    return [adresses userAppInteraction];
}

@end
