//
//  UserPinAndBlocksResponseHandler.m
//  Mapplas
//
//  Created by Belén  on 08/02/13.
//  Copyright (c) 2013 Mapplas. All rights reserved.
//

#import "UserPinAndBlocksResponseHandler.h"
#import "UserViewController.h"

@implementation UserPinAndBlocksResponseHandler

- (id)initWithAppBlockedMapper:(JSONToBlockedAppMapper *)app_blocked_mapper pinnedMapper:(JSONToPinnedAppMapper *)app_pinned_mapper user:(User *)_user viewController:(UserViewController *)user_view_controller {
    self = [super init];
    if (self) {
        blockedMapper = app_blocked_mapper;
        pinnedMapper = app_pinned_mapper;
        user = _user;
        userViewController = user_view_controller;
    }
    return self;
}

#pragma mark - GenericRequestHandler protocol methods
- (void)requestFinished:(id)JSON {
    // Parse apps
    NSDictionary *jsonObjects = JSON;
    
    NSArray *pinnedApps = [jsonObjects objectForKey:@"pinned"];
    NSArray *blockedApps = [jsonObjects objectForKey:@"blocked"];
    
    App *app = nil;
    NSMutableArray *pinnedAppsArray = [[NSMutableArray alloc] init];
    for (int i=0; i < pinnedApps.count; i++) {
        app = [pinnedMapper map:[pinnedApps objectAtIndex:i]];
        [pinnedAppsArray addObject:app];
    }
    
    NSMutableArray *blockedAppsArray = [[NSMutableArray alloc] init];
    for (int i=0; i < blockedApps.count; i++) {
        app = [blockedMapper map:[blockedApps objectAtIndex:i]];
        [blockedAppsArray addObject:app];
    }
    
    [user setPinnedApps:pinnedAppsArray];
    [user setBlockedApps:blockedAppsArray];
    [userViewController requestedDataLoaded];
}

- (void)requestFinishedWithErrors:(NSError *)error andReponse:(id)JSON {
    [user setPinnedApps:[[NSMutableArray alloc] init]];
    [user setBlockedApps:[[NSMutableArray alloc] init]];
    [userViewController requestedDataLoaded];
}

@end


/*
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
*/