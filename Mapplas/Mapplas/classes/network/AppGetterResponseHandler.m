//
//  AppGetterResponseHandler.m
//  Mapplas
//
//  Created by Belén  on 22/01/13.
//  Copyright (c) 2013 Mapplas. All rights reserved.
//

#import "AppGetterResponseHandler.h"

@implementation AppGetterResponseHandler

- (void)requestFinished:(ASIHTTPRequest *)request {
    NSLog(@"REQUEST FINISHED");
    NSString *response = [[request responseString] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
	NSDictionary *jsonData = [response JSONValue];
}

- (void)requestFailed:(ASIHTTPRequest *)request {
    NSLog(@"REQUEST FAILED");
}

@end
