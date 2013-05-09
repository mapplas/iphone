//
//  AppBlockRequest.h
//  Mapplas
//
//  Created by Belén  on 28/01/13.
//  Copyright (c) 2013 Mapplas. All rights reserved.
//

#import "BlockConnector.h"
#import "Environment.h"

@interface AppBlockRequest : NSObject {
    BlockConnector *connector;
}

- (void)doRequestWithAppId:(NSString *)app_id userId:(NSNumber *)user_id action:(NSString *)_action;

@end
