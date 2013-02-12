//
//  UserBlocksConnector.h
//  Mapplas
//
//  Created by Belén  on 08/02/13.
//  Copyright (c) 2013 Mapplas. All rights reserved.
//

#import "GenericConnector.h"
#import "UserBlocksResponseHandler.h"
#import "User.h"

@interface UserBlocksConnector : GenericConnector

- (id)initWithAddresses:(AbstractUrlAddresses *)addresses responseHandler:(UserBlocksResponseHandler *)response_handler;
- (void)requestWithUser:(User *)_user;

@end
