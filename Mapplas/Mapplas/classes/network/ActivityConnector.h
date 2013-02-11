//
//  ActivityConnector.h
//  Mapplas
//
//  Created by Belén  on 11/02/13.
//  Copyright (c) 2013 Mapplas. All rights reserved.
//

#import "GenericConnector.h"
#import "Environment.h"
#import "App.h"
#import "User.h"

@interface ActivityConnector : GenericConnector

- (id)initWithAddresses:(AbstractUrlAddresses *)_addresses;
- (void)requestWithCurrentLocation:(NSString *)current_location action:(NSString *)action app:(App *)app andUser:(User *)user;

@end
