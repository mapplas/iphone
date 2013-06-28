//
//  AppDetailConnector.h
//  Mapplas
//
//  Created by Belén  on 10/05/13.
//  Copyright (c) 2013 Mapplas. All rights reserved.
//

#import "GenericConnector.h"
#import "App.h"

@interface AppDetailConnector : GenericConnector {
    App *app;
}

- (id)initWithAddresses:(AbstractUrlAddresses *)addresses responseHandler:(id<GenericRequestHandler>)response_handler;
- (void)requestWithApp:(App *)_app;

@end
