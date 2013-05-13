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

#define APPS_PAGINATION_NUMBER 8;

@interface AppGetterConnector : GenericConnector {
    SuperModel *model;
}

- (id)initWithAddresses:(AbstractUrlAddresses *)_addresses responseHandler:(AppGetterResponseHandler *)response_handler;

- (void)requestWithModel:(SuperModel *)super_model andLocation:(CLLocation *)location;

@end
