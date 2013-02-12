//
//  UserPinUpsRequester.h
//  Mapplas
//
//  Created by Belén  on 08/02/13.
//  Copyright (c) 2013 Mapplas. All rights reserved.
//

#import "Environment.h"
#import "UserPinUpsConnector.h"
#import "UserPinUpsResponseHandler.h"
#import "UserViewController.h"
#import "JSONToAppMapper.h"

@interface UserPinUpsRequester : NSObject {
    UserPinUpsConnector *connector;
}

- (void)doRequestWithUser:(User *)_user viewController:(UserViewController *)user_view_controller;

@end
