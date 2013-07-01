//
//  UserAppInteractionConnector.h
//  Mapplas
//
//  Created by Belén  on 01/07/13.
//  Copyright (c) 2013 Mapplas. All rights reserved.
//

#import "GenericConnector.h"

@interface UserAppInteractionConnector : GenericConnector

- (id)initWithAddresses:(AbstractUrlAddresses *)_addresses;
- (void)requestWithUserId:(NSNumber *)user_id appId:(NSString *)app_id location:(NSString *)location;

@end
