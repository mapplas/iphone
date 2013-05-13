//
//  AppGetterConnector.m
//  Mapplas
//
//  Created by Belén  on 22/01/13.
//  Copyright (c) 2013 Mapplas. All rights reserved.
//

#import "AppGetterConnector.h"

@implementation AppGetterConnector

- (id)initWithAddresses:(AbstractUrlAddresses *)_addresses responseHandler:(AppGetterResponseHandler *)response_handler {
    return [super initWithAddresses:_addresses responseHandler:response_handler];
}

- (void)requestWithModel:(SuperModel *)super_model andLocation:(CLLocation *)location {
    model = super_model;
    
    CLLocationCoordinate2D coord = location.coordinate;
    
    [parameters setValue:[NSString stringWithFormat:@"%g", coord.latitude] forKey:@"lat"];
    [parameters setValue:[NSString stringWithFormat:@"%g", coord.longitude] forKey:@"lon"];
    [parameters setValue:[[model user] userId] forKey:@"uid"];
    [parameters setValue:[NSString stringWithFormat:@"%f", location.horizontalAccuracy] forKey:@"p"];
    
    [super initializeVariablesWithUrlAndSend:[self getUrl]];
}

- (NSString *)getUrl {
    NSInteger loadedApps = model.appList.getArray.count;
    NSInteger appsPagination = APPS_PAGINATION_NUMBER;
    
    return [adresses getApps:[NSNumber numberWithInt:loadedApps / appsPagination]];
}

@end
