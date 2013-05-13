//
//  AppDetailRequester.m
//  Mapplas
//
//  Created by Belén  on 10/05/13.
//  Copyright (c) 2013 Mapplas. All rights reserved.
//

#import "AppDetailRequester.h"

@implementation AppDetailRequester

- (void)doRequestWithApp:(App *)_app andViewController:(AppDetailViewController *)view_controller {
    Environment *environment = [Environment sharedInstance];
	AbstractUrlAddresses *urlAdresses = [environment addresses];
    AppDetailRequestHandler *handler = [[AppDetailRequestHandler alloc] initWithViewController:view_controller];
    
    connector = [[AppDetailConnector alloc] initWithAddresses:urlAdresses responseHandler:handler];
    [connector requestWithApp:_app];
}

@end
