//
//  AppDetailRequestHandler.m
//  Mapplas
//
//  Created by Belén  on 13/05/13.
//  Copyright (c) 2013 Mapplas. All rights reserved.
//

#import "AppDetailRequestHandler.h"
#import "AppDetailViewController.h"

@implementation AppDetailRequestHandler

- (id)initWithViewController:(AppDetailViewController *)view_controller app:(App *)_app {
    self = [super init];
    if (self) {
        viewController = view_controller;
        app = _app;
    }
    return self;
}

#pragma mark - AppDetailRequestHandler
- (void)requestFinished:(id)JSON {
    JSONToAppDetailMapper *appDetailMapper = [[JSONToAppDetailMapper alloc] init];
    [appDetailMapper map:JSON app:app];
    
    [viewController detailDataLoaded];
}

- (void)requestFinishedWithErrors:(NSError *)error andReponse:(id)JSON {
    NSLog(@"nok");
}

@end
