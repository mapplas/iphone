//
//  AppActivityRequest.h
//  Mapplas
//
//  Created by Belén  on 11/02/13.
//  Copyright (c) 2013 Mapplas. All rights reserved.
//

#import "ActivityConnector.h"
#import "Environment.h"
#import "App.h"
#import "User.h"

@interface AppActivityRequest : NSObject {
    ActivityConnector *connector;
}

- (void)doRequestWithLocation:(NSString *)location action:(NSString *)action app:(App *)app andUser:(User *)user;

@end
