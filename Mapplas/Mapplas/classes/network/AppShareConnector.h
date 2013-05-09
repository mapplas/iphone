//
//  AppShareConnector.h
//  Mapplas
//
//  Created by Belén  on 09/05/13.
//  Copyright (c) 2013 Mapplas. All rights reserved.
//

#import "GenericConnector.h"

@interface AppShareConnector : GenericConnector

- (id)initWithAddresses:(AbstractUrlAddresses *)_addresses;

- (void)requestWithAppId:(NSString *)app_id userId:(NSNumber *)user_id andLocation:(NSString *)currentLocation;

@end
