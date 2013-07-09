//
//  BlockConnector.m
//  Mapplas
//
//  Created by Belén  on 28/01/13.
//  Copyright (c) 2013 Mapplas. All rights reserved.
//

#import "BlockConnector.h"

@implementation BlockConnector

- (id)initWithAddresses:(AbstractUrlAddresses *)_addresses {
    return [super initWithAddresses:_addresses responseHandler:nil];
}

- (void)requestWithAppId:(NSNumber *)app_id userId:(NSNumber *)user_id action:(NSString *)_action{
    
    [parameters setValue:app_id forKey:@"app"];
    [parameters setValue:user_id forKey:@"uid"];
    [parameters setValue:_action forKey:@"s"];
    
    [super initializeVariablesWithUrlAndSend:[self getUrl]];
}

- (NSString *)getUrl {
    return [adresses blockApp];
}

@end
