//
//  AppShareRequest.h
//  Mapplas
//
//  Created by Belén  on 09/05/13.
//  Copyright (c) 2013 Mapplas. All rights reserved.
//

#import "AppShareConnector.h"
#import "Environment.h"

@interface AppShareRequest : NSObject {
    AppShareConnector *connector;
}

- (void)doRequestWithAppId:(NSString *)app_id userId:(NSNumber *)user_id andLocation:(NSString *)current_location via:(NSString *)_via;

@end
