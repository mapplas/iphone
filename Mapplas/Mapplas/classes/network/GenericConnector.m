//
//  GenericConnector.m
//  Mapplas
//
//  Created by Belén  on 22/01/13.
//  Copyright (c) 2013 Mapplas. All rights reserved.
//

#import "GenericConnector.h"

@implementation GenericConnector

@synthesize request = _request;
@synthesize handler = _handler;

- (id)initWithAddresses:(AbstractUrlAddresses *)_addresses variableListMapper:(VariableListMapper *)list_mapper responseHandler:(id<ASIHTTPRequestDelegate>)response_handler {
    self = [super init];
    if (self) {
        self.request = nil;
        adresses = _addresses;
        variableListMapper = list_mapper;
        self.handler = response_handler;
        
        parameters = [[VariableList alloc] init];
    }
    return self;
}

- (NSString *)getUrl {
    return @"IMPLEMENT IN SUBCLASS";
}

- (void)initializeVariablesWithUrlAndSend:(NSString *)url {
    [parameters addValue:[[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleVersion"] withKey:@"v"];
    
    ASIFormDataRequest *asiRequest = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:url]];
	self.request = asiRequest;
	
	[variableListMapper insert:parameters into:self.request];
	[self.request setResponseEncoding:NSUTF8StringEncoding];
	[self.request setDelegate:self.handler];
	[self.request startAsynchronous];
}

@end
