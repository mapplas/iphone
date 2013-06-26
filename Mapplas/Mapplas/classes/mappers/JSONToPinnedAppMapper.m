//
//  JSONToPinnedAppMapper.m
//  Mapplas
//
//  Created by Belén  on 26/06/13.
//  Copyright (c) 2013 Mapplas. All rights reserved.
//

#import "JSONToPinnedAppMapper.h"

@implementation JSONToPinnedAppMapper

- (id)init {
    
	NSArray *mappingProperties = [[NSArray alloc] initWithObjects:
                                  [[KeyValueScappedMapper alloc] initWithKey:@"id" action:@selector(setAppId:)],
                                  [[KeyValueScappedMapper alloc] initWithKey:@"n" action:@selector(setName:)],
                                  [[KeyValueScappedMapper alloc] initWithKey:@"i" action:@selector(setAppLogo:)],
                                  [[KeyValueScappedMapper alloc] initWithKey:@"a" action:@selector(setAppPinnedGeocodedLocation:)],
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
