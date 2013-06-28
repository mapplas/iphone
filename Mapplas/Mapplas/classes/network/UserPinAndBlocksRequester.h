//
//  UserPinAndBlocksRequester.h
//  Mapplas
//
//  Created by Belén  on 08/02/13.
//  Copyright (c) 2013 Mapplas. All rights reserved.
//

#import "Environment.h"
#import "UserPinAndBlocksConnector.h"
#import "UserPinAndBlocksResponseHandler.h"
#import "UserViewController.h"
#import "JSONToBlockedAppMapper.h"
#import "JSONToPinnedAppMapper.h"

@interface UserPinAndBlocksRequester : NSObject {
    UserPinAndBlocksConnector *connector;
}

- (void)doRequestWithUser:(User *)_user viewController:(UserViewController *)user_view_controller;

@end
