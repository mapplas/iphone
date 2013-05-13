//
//  AppDetailConnector.m
//  Mapplas
//
//  Created by Belén  on 10/05/13.
//  Copyright (c) 2013 Mapplas. All rights reserved.
//

#import "AppDetailConnector.h"

@implementation AppDetailConnector

- (id)initWithAddresses:(AbstractUrlAddresses *)addresses responseHandler:(id<GenericRequestHandler>)response_handler {
    return [super initWithAddresses:addresses responseHandler:response_handler];
}

- (void)requestWithApp:(App *)_app {
    app = _app;

    [parameters setValue:[[NSLocale preferredLanguages] objectAtIndex:0] forKey:@"l"];
    
    [super initializeVariablesWithUrlAndSend:[self getUrl]];
}

- (NSString *)getUrl {
    return [adresses appDetail:app.appId];
}

@end
