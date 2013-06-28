//
//  UserIdentificationResponseHandler.m
//  Mapplas
//
//  Created by Belén  on 18/01/13.
//  Copyright (c) 2013 Mapplas. All rights reserved.
//

#import "UserIdentificationResponseHandler.h"
#import "JSONToUserMapper.h"
#import "AppsViewController.h"

@implementation UserIdentificationResponseHandler

- (id)initWithSuperModel:(SuperModel *)_model andViewController:(AppsViewController *)view_controller {
    self = [super init];
    if (self) {
        model = _model;
        viewController = view_controller;
    }
    return self;
}

- (void)requestFinished:(id)JSON {
    NSDictionary *jsonResponse = JSON;
    JSONToUserMapper *userMapper = [[JSONToUserMapper alloc] init];
    User *currentUser = [userMapper map:jsonResponse];
    
    [model setUser:currentUser];
    
    [viewController userDataLoaded];
}

- (void)requestFinishedWithErrors:(NSError *)error andReponse:(id)JSON {
    [viewController userDataLoadingError];
}

@end
