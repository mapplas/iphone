//
//  UserBlocksConnector.m
//  Mapplas
//
//  Created by Belén  on 08/02/13.
//  Copyright (c) 2013 Mapplas. All rights reserved.
//

#import "UserBlocksConnector.h"

@implementation UserBlocksConnector

- (id)initWithAddresses:(AbstractUrlAddresses *)addresses responseHandler:(UserBlocksResponseHandler *)response_handler {
    return [super initWithAddresses:addresses responseHandler:response_handler];
}

- (void)requestWithUser:(User *)_user {
    [parameters setValue:[_user userId] forKey:@"uid"];
    
    [super initializeVariablesWithUrlAndSend:[self getUrl]];
}

- (NSString *)getUrl {
    return [adresses userBlocks];
}

@end
