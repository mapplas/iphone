//
//  UserPinAndBlocksResponseHandler.h
//  Mapplas
//
//  Created by Belén  on 08/02/13.
//  Copyright (c) 2013 Mapplas. All rights reserved.
//

#import "GenericRequestHandler.h"
#import "JSONToPinnedBlockedAppMapper.h"
#import "User.h"

@class UserViewController;

@interface UserPinAndBlocksResponseHandler : NSObject <GenericRequestHandler> {
    JSONToPinnedBlockedAppMapper *mapper;
    User *user;
    UserViewController *userViewController;
}

- (id)initWithAppMapper:(JSONToPinnedBlockedAppMapper *)app_mapper user:(User *)_user viewController:(UserViewController *)user_view_controller;

@end
