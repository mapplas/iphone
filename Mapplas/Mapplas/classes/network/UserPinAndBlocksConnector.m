//
//  UserPinAndBlocksConnector.m
//  Mapplas
//
//  Created by Belén  on 08/02/13.
//  Copyright (c) 2013 Mapplas. All rights reserved.
//

#import "UserPinAndBlocksConnector.h"

@implementation UserPinAndBlocksConnector

- (id)initWithAddresses:(AbstractUrlAddresses *)addresses responseHandler:(UserPinAndBlocksResponseHandler *)response_handler {
    return [super initWithAddresses:addresses responseHandler:response_handler];
}

- (void)requestWithUser:(User *)_user {
    user = _user;
    [super initializeVariablesWithUrlAndSend:[self getUrl]];
}

- (NSString *)getUrl {
    return [adresses userPinAndBlocks:user.userId];
}

@end
