//
//  BlockConnector.h
//  Mapplas
//
//  Created by Belén  on 28/01/13.
//  Copyright (c) 2013 Mapplas. All rights reserved.
//

#import "GenericConnector.h"

@interface BlockConnector : GenericConnector

- (id)initWithAddresses:(AbstractUrlAddresses *)_addresses;

- (void)requestWithAppId:(NSNumber *)app_id userId:(NSNumber *)user_id action:(NSString *)_action;

@end
