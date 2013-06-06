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

- (void)requestWithModel:(SuperModel *)super_model andLocation:(CLLocation *)location resetPagination:(BOOL)_reset_pagination {
    model = super_model;
    reset_pagination = _reset_pagination;
    
    CLLocationCoordinate2D coord = location.coordinate;
    
    [parameters setValue:[NSString stringWithFormat:@"%g", coord.latitude] forKey:@"lat"];
    [parameters setValue:[NSString stringWithFormat:@"%g", coord.longitude] forKey:@"lon"];
    [parameters setValue:[[model user] userId] forKey:@"uid"];
    [parameters setValue:[NSString stringWithFormat:@"%f", location.horizontalAccuracy] forKey:@"p"];
    [parameters setValue:[[NSLocale preferredLanguages] objectAtIndex:0] forKey:@"l"];
    
    [super initializeVariablesWithUrlAndSend:[self getUrl]];
}

- (NSString *)getUrl {
    NSInteger page = 0;
    
    if (!reset_pagination) {
        NSInteger loadedApps = model.appList.getArray.count;
        NSInteger appsPagination = APPS_PAGINATION_NUMBER;
        page = loadedApps / appsPagination;
    }
    
    return [adresses getApps:[NSNumber numberWithInt:page]];
}

@end
