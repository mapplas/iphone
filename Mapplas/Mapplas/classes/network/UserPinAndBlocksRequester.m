//
//  UserPinAndBlocksRequester.m
//  Mapplas
//
//  Created by Belén  on 08/02/13.
//  Copyright (c) 2013 Mapplas. All rights reserved.
//

#import "UserPinAndBlocksRequester.h"

@implementation UserPinAndBlocksRequester

- (void)doRequestWithUser:(User *)_user viewController:(UserViewController *)user_view_controller {
    Environment *environment = [Environment sharedInstance];
	AbstractUrlAddresses *urlAdresses = [environment addresses];
    JSONToBlockedAppMapper *blockMapper = [[JSONToBlockedAppMapper alloc] init];
    JSONToPinnedAppMapper *pinMapper = [[JSONToPinnedAppMapper alloc] init];
    UserPinAndBlocksResponseHandler *handler = [[UserPinAndBlocksResponseHandler alloc] initWithAppBlockedMapper:blockMapper pinnedMapper:pinMapper user:_user viewController:user_view_controller];
    
    connector = [[UserPinAndBlocksConnector alloc] initWithAddresses:urlAdresses responseHandler:handler];
    [connector requestWithUser:_user];
}

@end
