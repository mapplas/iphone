//
//  ActivityConnector.m
//  Mapplas
//
//  Created by Belén  on 11/02/13.
//  Copyright (c) 2013 Mapplas. All rights reserved.
//

#import "ActivityConnector.h"

@implementation ActivityConnector

- (id)initWithAddresses:(AbstractUrlAddresses *)_addresses {
    return [super initWithAddresses:_addresses responseHandler:nil];
}

- (void)requestWithCurrentLocation:(NSString *)current_location action:(NSString *)action app:(App *)app andUser:(User *)user {
    [parameters setValue:current_location forKey:@"l"];
    [parameters setValue:action forKey:@"a"];
    [parameters setValue:user.userId forKey:@"uid"];

    if (app != nil) {
        [parameters setValue:app.appId forKey:@"id"];
    }
    else {
        [parameters setValue:@"0" forKey:@"id"];
    }
    
    [super initializeVariablesWithUrlAndSend:[self getUrl]];
}

- (NSString *)getUrl {
    return [adresses activity];
}

@end
