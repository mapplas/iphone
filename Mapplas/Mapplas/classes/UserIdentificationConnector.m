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

- (id)initWithAddresses:(AbstractUrlAddresses *)_addresses variableListMapper:(VariableListMapper *)list_mapper {
    if (self = [super init]) {
        self.request = nil;
        adresses = _addresses;
        variableListMapper = list_mapper;
    }
    return self;
}

- (void)requestWithModel:(SuperModel *)super_model {
    model = super_model;
    
    VariableList *parameters = [[VariableList alloc] init];
    [parameters addValue:@"v" withKey:[[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleVersion"]];
    [parameters addValue:@"l" withKey:[model currentLocation]];
    [parameters addValue:@"ii" withKey:[model currentImei]];
    
    NSString *url = [self getUrl];
	ASIFormDataRequest *asiRequest = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:url]];
	self.request = asiRequest;
	
	[variableListMapper insert:parameters into:self.request];
	[self.request setResponseEncoding:NSUTF8StringEncoding];
	[self.request setDelegate:delegate];
	[self.request startAsynchronous];
}

- (NSString *)getUrl {
    return [adresses identifyUser];
}

@end
