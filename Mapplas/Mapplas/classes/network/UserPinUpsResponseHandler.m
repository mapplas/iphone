//
//  UserPinUpsResponseHandler.m
//  Mapplas
//
//  Created by Belén  on 08/02/13.
//  Copyright (c) 2013 Mapplas. All rights reserved.
//

#import "UserPinUpsResponseHandler.h"
#import "UserViewController.h"

@implementation UserPinUpsResponseHandler

- (id)initWithAppMapper:(JSONToAppMapper *)app_mapper user:(User *)_user viewController:(UserViewController *)user_view_controller {
    self = [super init];
    if (self) {
        appMapper = app_mapper;
        user = _user;
        userViewController = user_view_controller;
    }
    return self;
}

#pragma mark - GenericRequestHandler protocol methods
- (void)requestFinished:(id)JSON {
    // Parse apps
    NSArray *jsonObjects = JSON;
    
    App *app = nil;
    NSMutableArray *pinnedApps = [[NSMutableArray alloc] init];
    for (int i=0; i < jsonObjects.count; i++) {
        app = [appMapper map:[jsonObjects objectAtIndex:i]];
        [pinnedApps addObject:app];
    }
    
    [user setPinnedApps:pinnedApps];
    [userViewController requestedDataLoaded];
}

- (void)requestFinishedWithErrors:(NSError *)error andReponse:(id)JSON {
    [user setPinnedApps:[[NSMutableArray alloc] init]];
    [userViewController requestedDataLoaded];
}

@end
