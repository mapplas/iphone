//
//  UserAppInteractionRequester.h
//  Mapplas
//
//  Created by Belén  on 01/07/13.
//  Copyright (c) 2013 Mapplas. All rights reserved.
//

#import "UserAppInteractionConnector.h"
#import "Environment.h"

@interface UserAppInteractionRequester : NSObject {
    UserAppInteractionConnector *connector;
}

- (void)doRequestWithUserId:(NSNumber *)user_id appId:(NSNumber *)app_id location:(NSString *)location;

@end
