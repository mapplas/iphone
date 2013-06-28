//
//  JSONToBlockedAppMapper.m
//  Mapplas
//
//  Created by Belén  on 10/05/13.
//  Copyright (c) 2013 Mapplas. All rights reserved.
//

#import "JSONToBlockedAppMapper.h"

@implementation JSONToBlockedAppMapper

- (id)init {
    
	NSArray *mappingProperties = [[NSArray alloc] initWithObjects:
                                  [[KeyValueScappedMapper alloc] initWithKey:@"id" action:@selector(setAppId:)],
                                  [[KeyValueScappedMapper alloc] initWithKey:@"n" action:@selector(setName:)],
                                  [[KeyValueScappedMapper alloc] initWithKey:@"i" action:@selector(setAppLogo:)],
                                  nil];
    
    self = [super initWithMappers:mappingProperties];
    
    return self;
}

- (App *)map:(NSDictionary *)json {
    App *app = [[App alloc] init];
    
    [super map:json target:app];
    
    return app;
}

@end
