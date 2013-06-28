//
//  UserEditConnector.m
//  Mapplas
//
//  Created by Belén  on 11/02/13.
//  Copyright (c) 2013 Mapplas. All rights reserved.
//

#import "UserEditConnector.h"

@implementation UserEditConnector

- (id)initWithAddresses:(AbstractUrlAddresses *)_addresses {
    return [super initWithAddresses:_addresses responseHandler:nil];
}

- (void)requestWithUser:(User *)user {
    
//    [parameters setValue:user.name forKey:@"n"];
//    [parameters setValue:user.email forKey:@"e"];
    [parameters setValue:user.imei forKey:@"ii"];
    [parameters setValue:user.userId forKey:@"uid"];
    
    NSUserDefaults *defs = [NSUserDefaults standardUserDefaults];
    NSArray *languages = [defs objectForKey:@"AppleLanguages"];
    [parameters setValue:[languages objectAtIndex:0] forKey:@"l"];
    
    [super initializeVariablesWithUrlAndSend:[self getUrl]];
}

- (NSString *)getUrl {
    return [adresses editUser];
}

@end
