//
//  AppDetailRequester.h
//  Mapplas
//
//  Created by Belén  on 10/05/13.
//  Copyright (c) 2013 Mapplas. All rights reserved.
//

#import "AppDetailConnector.h"
#import "Environment.h"
#import "AppDetailViewController.h"
#import "AppDetailRequestHandler.h"

@interface AppDetailRequester : NSObject {
    AppDetailConnector *connector;
    AppDetailViewController *viewController;
}

- (void)doRequestWithApp:(App *)_app andViewController:(AppDetailViewController *)view_controller;

@end
