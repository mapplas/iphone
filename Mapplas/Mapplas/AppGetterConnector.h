//
//  AppGetterConnector.h
//  Mapplas
//
//  Created by Belén  on 22/01/13.
//  Copyright (c) 2013 Mapplas. All rights reserved.
//

#import "GenericConnector.h"
#import "AppGetterResponseHandler.h"
#import "SuperModel.h"
#import <CoreLocation/CoreLocation.h>

@interface AppGetterConnector : GenericConnector

- (id)initWithAddresses:(AbstractUrlAddresses *)_addresses variableListMapper:(VariableListMapper *)list_mapper responseHandler:(AppGetterResponseHandler *)response_handler;

- (void)requestWithModel:(SuperModel *)super_model andLocation:(CLLocation *)location;

@end
