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

#pragma mark - AsiHTTPResponse delegate
- (void)errorLog:(NSString *)from request:(ASIHTTPRequest *)request {
    NSLog(@"-Response delegate, %@.\n-Url: %@\n-Response: %@\n", from, [request url], [request responseString]);
}

- (void)requestFinished:(ASIHTTPRequest *)request {
	NSString *response = [[request responseString] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
	NSDictionary *jsonData = [response JSONValue];
    
    JSONToUserMapper *userMapper = [[JSONToUserMapper alloc] init];
    User *currentUser = [userMapper map:jsonData];

    [model setUser:currentUser];
}

- (void)requestFailed:(ASIHTTPRequest *)request {
	NSError *error = [request error];
	[self errorLog:[@"request failed: " stringByAppendingString:[error description]] request:request];
}
@end
