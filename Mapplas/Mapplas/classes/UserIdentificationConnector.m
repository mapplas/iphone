//
//  UserIdentificationConnector.m
//  Mapplas
//
//  Created by Belén  on 18/01/13.
//  Copyright (c) 2013 Mapplas. All rights reserved.
//

#import "UserIdentificationConnector.h"

@implementation UserIdentificationConnector

@synthesize request = _request;

- (id)initWithAddresses:(AbstractUrlAddresses *)_addresses variableListMapper:(VariableListMapper *)list_mapper responseHandler:(UserIdentificationResponseHandler *)response_handler {
    self = [super init];
    if (self) {
        self.request = nil;
        adresses = _addresses;
        variableListMapper = list_mapper;
        handler = response_handler;
    }
    return self;
}

- (void)requestWithModel:(SuperModel *)super_model {
    model = super_model;
    
    VariableList *parameters = [[VariableList alloc] init];
    [parameters addValue:[[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleVersion"] withKey:@"v"];
    [parameters addValue:[model currentLocation] withKey:@"l"];
    [parameters addValue:[model currentImei] withKey:@"ii"];
    
    NSString *url = [self getUrl];
	ASIFormDataRequest *asiRequest = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:url]];
	self.request = asiRequest;
	
	[variableListMapper insert:parameters into:self.request];
	[self.request setResponseEncoding:NSUTF8StringEncoding];
	[self.request setDelegate:handler];
	[self.request startAsynchronous];
}

- (NSString *)getUrl {
    return [adresses identifyUser];
}

@end
