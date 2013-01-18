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
								  [[KeyValueMapper alloc] initWithKey:@"IDUser" action:@selector(setUserId:)],
                                  [[KeyValueScappedMapper alloc] initWithKey:@"Name" action:@selector(setName:)],
                                  [[KeyValueScappedMapper alloc] initWithKey:@"Lastname" action:@selector(setLastName:)],
                                  [[KeyValueScappedMapper alloc] initWithKey:@"Gender" action:@selector(setGender:)],
                                  [[KeyValueScappedMapper alloc] initWithKey:@"Birthdate" action:@selector(setBirthdate:)],
                                  [[KeyValueScappedMapper alloc] initWithKey:@"Login" action:@selector(setLogin:)],
                                  [[KeyValueScappedMapper alloc] initWithKey:@"Password" action:@selector(setPassword:)],
                                  [[KeyValueScappedMapper alloc] initWithKey:@"Email" action:@selector(setEmail:)],
                                  [[KeyValueScappedMapper alloc] initWithKey:@"Imei" action:@selector(setImei:)],
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
