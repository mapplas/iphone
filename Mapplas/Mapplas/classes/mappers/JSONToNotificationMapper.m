//
//  JSONToNotificationMapper.m
//  Mapplas
//
//  Created by Belén  on 12/02/13.
//  Copyright (c) 2013 Mapplas. All rights reserved.
//

#import "JSONToNotificationMapper.h"

@implementation JSONToNotificationMapper

- (id)init {
    NSArray *mappingProperties = [[NSArray alloc] initWithObjects:
								  [[KeyValueScappedMapper alloc] initWithKey:@"IDNewsfeed" action:@selector(setIdentifier:)],
                                  [[KeyValueScappedMapper alloc] initWithKey:@"IDCompany" action:@selector(setCompanyId:)],
                                  [[KeyValueScappedMapper alloc] initWithKey:@"IDLocalization" action:@selector(setAppId:)],
                                  
                                  [[KeyValueScappedMapper alloc] initWithKey:@"Title" action:@selector(setName:)],
                                  [[KeyValueScappedMapper alloc] initWithKey:@"Body" action:@selector(setDescription:)],
                                  [[KeyValueScappedMapper alloc] initWithKey:@"Hour" action:@selector(setHour:)],
                                  [[KeyValueScappedMapper alloc] initWithKey:@"Date" action:@selector(setDate:)],
                                  nil];
    
    self = [super initWithMappers:mappingProperties];
    
    return self;
}

- (Notification *)map:(NSDictionary *)data {
    Notification *notification = [[Notification alloc] init];
    
    [super map:data target:notification];
    
    return notification;
}

@end
