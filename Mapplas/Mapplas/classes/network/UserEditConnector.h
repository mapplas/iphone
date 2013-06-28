//
//  UserEditConnector.h
//  Mapplas
//
//  Created by Belén  on 11/02/13.
//  Copyright (c) 2013 Mapplas. All rights reserved.
//

#import "GenericConnector.h"
#import "User.h"

@interface UserEditConnector : GenericConnector

- (id)initWithAddresses:(AbstractUrlAddresses *)_addresses;
- (void)requestWithUser:(User *)user;

@end
