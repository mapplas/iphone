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

- (id)initWithViewController:(AppDetailViewController *)view_controller {
    self = [super init];
    if (self) {
        viewController = view_controller;
    }
    return self;
}

#pragma mark - AppDetailRequestHandler
- (void)requestFinished:(id)JSON {
    NSLog(@"ok");
}

- (void)requestFinishedWithErrors:(NSError *)error andReponse:(id)JSON {
    NSLog(@"nok");
}

@end
