//
//  UserPinAndBlocksConnector.h
//  Mapplas
//
//  Created by Belén  on 08/02/13.
//  Copyright (c) 2013 Mapplas. All rights reserved.
//

#import "GenericConnector.h"
#import "UserPinAndBlocksResponseHandler.h"
#import "User.h"

@interface UserPinAndBlocksConnector : GenericConnector {
    User *user;
}

- (id)initWithAddresses:(AbstractUrlAddresses *)addresses responseHandler:(UserPinAndBlocksResponseHandler *)response_handler;
- (void)requestWithUser:(User *)_user;

@end
