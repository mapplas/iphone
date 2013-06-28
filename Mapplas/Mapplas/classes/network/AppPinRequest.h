//
//  AppPinRequest.h
//  Mapplas
//
//  Created by Belén  on 28/01/13.
//  Copyright (c) 2013 Mapplas. All rights reserved.
//

#import "Environment.h"
#import "PinConnector.h"

@interface AppPinRequest : NSObject {
    PinConnector *connector;
}

- (void)doRequestWithAppId:(NSString *)app_id userId:(NSNumber *)user_id action:(NSString *)_action andLocation:(NSString *)current_location;

@end
