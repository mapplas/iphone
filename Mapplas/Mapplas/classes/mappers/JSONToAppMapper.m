//
//  JSONToAppMapper.m
//  Mapplas
//
//  Created by Belén  on 23/01/13.
//  Copyright (c) 2013 Mapplas. All rights reserved.
//

#import "JSONToAppMapper.h"

@implementation JSONToAppMapper

- (id)init {
    
	NSArray *mappingProperties = [[NSArray alloc] initWithObjects:
                                  [[KeyValueScappedMapper alloc] initWithKey:@"id" action:@selector(setAppId:)],
                                  [[KeyValueScappedMapper alloc] initWithKey:@"n" action:@selector(setName:)],
                                  [[KeyValueScappedMapper alloc] initWithKey:@"i" action:@selector(setAppLogo:)],
                                  [[KeyValueScappedMapper alloc] initWithKey:@"sc" action:@selector(setAppUrlScheme:)],
//                                  [[KeyValueMapper alloc] initWithKey:@"asid" action:@selector(setAppAppStoreId:)],
                                  
                                  [[KeyValueScappedMapper alloc] initWithKey:@"type" action:@selector(setType:)],

                                  [[KeyValueScappedMapper alloc] initWithKey:@"pin" action:@selector(setAuxPin:)],
                                  [[KeyValueMapper alloc] initWithKey:@"tpin" action:@selector(setAuxTotalPins:)],

                                  [[KeyValueMapper alloc] initWithKey:@"pr" action:@selector(setAppPrice:)],
                                  [[KeyValueScappedMapper alloc] initWithKey:@"st" action:@selector(setMarket:)],
                                  [[KeyValueScappedMapper alloc] initWithKey:@"cu" action:@selector(setCurrencyCode:)],
                                  
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
