//
//  UserBlocksRequester.h
//  Mapplas
//
//  Created by Belén  on 08/02/13.
//  Copyright (c) 2013 Mapplas. All rights reserved.
//

#import "Environment.h"
#import "UserBlocksConnector.h"
#import "UserBlocksResponseHandler.h"

@class UserViewController;

@interface UserBlocksRequester : NSObject {
    UserBlocksConnector *connector;
}

- (void)doRequestWithUser:(User *)_user viewController:(UserViewController *)user_view_controller;

@end
