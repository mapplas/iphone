//
//  UserIdentificationResponseHandler.m
//  Mapplas
//
//  Created by Belén  on 18/01/13.
//  Copyright (c) 2013 Mapplas. All rights reserved.
//

#import "UserIdentificationResponseHandler.h"

@implementation UserIdentificationResponseHandler

#pragma mark - AsiHTTPResponse delegate
- (void)errorLog:(NSString *)from request:(ASIHTTPRequest *)request {
    NSLog(@"-Response delegate, %@.\n-Url: %@\n-Response: %@\n", from, [request url], [request responseString]);
}

- (void)requestFinished:(ASIHTTPRequest *)request {
	NSString *response = [[request responseString] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
	NSDictionary *jsonData = [response JSONValue];
    
}

- (void)requestFailed:(ASIHTTPRequest *)request {
	NSError *error = [request error];
	[self errorLog:[@"request failed: " stringByAppendingString:[error description]] request:request];
}
@end
