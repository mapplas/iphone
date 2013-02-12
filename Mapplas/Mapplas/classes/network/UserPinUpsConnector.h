//
//  UserPinUpsConnector.h
//  Mapplas
//
//  Created by Belén  on 08/02/13.
//  Copyright (c) 2013 Mapplas. All rights reserved.
//

#import "GenericConnector.h"
#import "UserPinUpsResponseHandler.h"
#import "User.h"

@interface UserPinUpsConnector : GenericConnector

- (id)initWithAddresses:(AbstractUrlAddresses *)addresses responseHandler:(UserPinUpsResponseHandler *)response_handler;
- (void)requestWithUser:(User *)_user;

@end
