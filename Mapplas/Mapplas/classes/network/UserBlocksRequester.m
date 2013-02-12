//
//  UserBlocksRequester.m
//  Mapplas
//
//  Created by Belén  on 08/02/13.
//  Copyright (c) 2013 Mapplas. All rights reserved.
//

#import "UserBlocksRequester.h"
#import "UserViewController.h"

@implementation UserBlocksRequester

- (void)doRequestWithUser:(User *)_user viewController:(UserViewController *)user_view_controller {
    Environment *environment = [Environment sharedInstance];
	AbstractUrlAddresses *urlAdresses = [environment addresses];
    JSONToAppMapper *appMapper = [[JSONToAppMapper alloc] init];
    UserBlocksResponseHandler *handler = [[UserBlocksResponseHandler alloc] initWithAppMapper:appMapper user:_user viewController:user_view_controller];
    
    connector = [[UserBlocksConnector alloc] initWithAddresses:urlAdresses responseHandler:handler];
    [connector requestWithUser:_user];
}

@end
