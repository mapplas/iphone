//
//  UserEditRequester.h
//  Mapplas
//
//  Created by Belén  on 11/02/13.
//  Copyright (c) 2013 Mapplas. All rights reserved.
//

#import "UserEditConnector.h"
#import "Environment.h"
#import "UserEditConnector.h"

@interface UserEditRequester : NSObject {
    UserEditConnector *connector;
}

- (void)doRequestWithUser:(User *)_user;

@end
