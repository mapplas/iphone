//
//  UserPinAndBlocksResponseHandler.h
//  Mapplas
//
//  Created by Belén  on 08/02/13.
//  Copyright (c) 2013 Mapplas. All rights reserved.
//

#import "GenericRequestHandler.h"
#import "JSONToBlockedAppMapper.h"
#import "JSONToPinnedAppMapper.h"
#import "User.h"

@class UserViewController;

@interface UserPinAndBlocksResponseHandler : NSObject <GenericRequestHandler> {
    JSONToBlockedAppMapper *blockedMapper;
    JSONToPinnedAppMapper *pinnedMapper;
    User *user;
    UserViewController *userViewController;
}

- (id)initWithAppBlockedMapper:(JSONToBlockedAppMapper *)app_blocked_mapper pinnedMapper:(JSONToPinnedAppMapper *)app_pinned_mapper user:(User *)_user viewController:(UserViewController *)user_view_controller;

@end
