//
//  JSONToUserMapper.m
//  Mapplas
//
//  Created by Belén  on 18/01/13.
//  Copyright (c) 2013 Mapplas. All rights reserved.
//

#import "KeyValueScappedMapper.h"

@implementation KeyValueScappedMapper

@synthesize key = _key;
@synthesize action = _action;

- (id)initWithKey:(NSString *)key action:(SEL)action {
    self = [super init];
    if (self) {
        _key = key;
		_action = action;
		conversor = [[HtmlEntitiesConversor alloc] init];
    }
    return self;
}

- (void)map:(NSDictionary *)data target:(id)target {
	id scappedObject = nil;
	
	if ([data objectForKey:[self key]] != nil) {
		scappedObject = [conversor convertHtmlEntities:[data objectForKey:[self key]]];
	}
	
	if (target != nil && scappedObject != nil) {
		[target performSelector:[self action] withObject:scappedObject];
	}
}

@end
