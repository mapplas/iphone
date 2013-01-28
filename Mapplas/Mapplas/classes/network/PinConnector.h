//
//  PinConnector.h
//  Mapplas
//
//  Created by Belén  on 28/01/13.
//  Copyright (c) 2013 Mapplas. All rights reserved.
//

#import "GenericConnector.h"

@interface PinConnector : GenericConnector

- (id)initWithAddresses:(AbstractUrlAddresses *)_addresses;

- (void)requestWithAppId:(NSString *)app_id userId:(NSString *)user_id action:(NSString *)_action andLocation:(NSString *)currentLocation;

@end
