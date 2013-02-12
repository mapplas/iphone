//
//  UserPinUpsResponseHandler.h
//  Mapplas
//
//  Created by Belén  on 08/02/13.
//  Copyright (c) 2013 Mapplas. All rights reserved.
//

#import "GenericRequestHandler.h"
#import "JSONToAppMapper.h"
#import "User.h"

@class UserViewController;

@interface UserPinUpsResponseHandler : NSObject <GenericRequestHandler> {
    JSONToAppMapper *appMapper;
    User *user;
    UserViewController *userViewController;
}

- (id)initWithAppMapper:(JSONToAppMapper *)app_mapper user:(User *)_user viewController:(UserViewController *)user_view_controller;

@end
