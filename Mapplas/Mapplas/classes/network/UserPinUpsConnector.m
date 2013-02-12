//
//  UserPinUpsConnector.m
//  Mapplas
//
//  Created by Belén  on 08/02/13.
//  Copyright (c) 2013 Mapplas. All rights reserved.
//

#import "UserPinUpsConnector.h"

@implementation UserPinUpsConnector

- (id)initWithAddresses:(AbstractUrlAddresses *)addresses responseHandler:(UserPinUpsResponseHandler *)response_handler {
    return [super initWithAddresses:addresses responseHandler:response_handler];
}

- (void)requestWithUser:(User *)_user {    
    [parameters setValue:[_user userId] forKey:@"uid"];
    
    [super initializeVariablesWithUrlAndSend:[self getUrl]];
}

- (NSString *)getUrl {
    return [adresses userPinUps];
}

@end
