//
//  JSONToUserMapper.m
//  Mapplas
//
//  Created by Belén  on 18/01/13.
//  Copyright (c) 2013 Mapplas. All rights reserved.
//

#import "JSONToUserMapper.h"
#import "KeyValueMapper.h"
#import "KeyValueScappedMapper.h"

@implementation JSONToUserMapper

- (id)init {
    
	NSArray *mappingProperties = [[NSArray alloc] initWithObjects:
								  [[KeyValueMapper alloc] initWithKey:@"user" action:@selector(setUserId:)],
                                  [[KeyValueScappedMapper alloc] initWithKey:@"tel" action:@selector(setTel:)],
                                  [[KeyValueScappedMapper alloc] initWithKey:@"imei" action:@selector(setImei:)],
                                  nil];
    self = [super initWithMappers:mappingProperties];
    
    return self;
}

- (User *)map:(NSDictionary *)json {
	User *user = [[User alloc] init];
	
	[super map:json target:user];
	
	return user;
}


@end
