//
//  UserIdentificationResponseHandler.m
//  Mapplas
//
//  Created by Belén  on 18/01/13.
//  Copyright (c) 2013 Mapplas. All rights reserved.
//

#import "UserIdentificationResponseHandler.h"
#import "JSONToUserMapper.h"

@implementation UserIdentificationResponseHandler

- (id)initWithSuperModel:(SuperModel *)_model {
    self = [super init];
    if (self) {
        model = _model;
    }
    return self;
}

- (void)requestFinished:(id)JSON {
    NSDictionary *jsonResponse = JSON;
    JSONToUserMapper *userMapper = [[JSONToUserMapper alloc] init];
    User *currentUser = [userMapper map:jsonResponse];
    
    [model setUser:currentUser];
}

- (void)requestFinishedWithErrors:(NSError *)error andReponse:(id)JSON {
    NSLog(@"Response delegate error, %@, %@", [error description], JSON);
}

@end
