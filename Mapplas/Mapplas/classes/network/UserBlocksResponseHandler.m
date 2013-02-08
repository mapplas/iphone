//
//  UserBlocksResponseHandler.m
//  Mapplas
//
//  Created by Belén  on 08/02/13.
//  Copyright (c) 2013 Mapplas. All rights reserved.
//

#import "UserBlocksResponseHandler.h"

@implementation UserBlocksResponseHandler

- (id)initWithAppMapper:(JSONToAppMapper *)app_mapper user:(User *)_user viewController:(UserViewController *)user_view_controller {
    self = [super init];
    if (self) {
        appMapper = app_mapper;
        user = _user;
        userViewController = user_view_controller;
    }
    return self;
}

- (void)requestFinished:(id)JSON {
    // Parse apps
    NSArray *jsonObjects = JSON;
    
    App *app = nil;
    NSMutableArray *blockedApps = [[NSMutableArray alloc] init];
    for (int i=0; i < jsonObjects.count; i++) {
        app = [appMapper map:[jsonObjects objectAtIndex:i]];
        [blockedApps addObject:app];
    }
    
    [user setBlockedApps:blockedApps];
    [userViewController requestedDataLoaded];
}

- (void)requestFinishedWithErrors:(NSError *)error andReponse:(id)JSON {
    [user setPinnedApps:[[NSMutableArray alloc] init]];
    [userViewController requestedDataLoaded];
}

@end
