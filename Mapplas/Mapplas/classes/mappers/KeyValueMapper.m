//
//  JSONToUserMapper.m
//  Mapplas
//
//  Created by Belén  on 18/01/13.
//  Copyright (c) 2013 Mapplas. All rights reserved.
//

#import "KeyValueMapper.h"

@implementation KeyValueMapper

@synthesize key = _key;
@synthesize action = _action;

- (id)initWithKey:(NSString *)key action:(SEL)action {
    self = [super init];
    if (self) {
        _key = key;
		_action = action;
    }
    return self;
}

- (void)map:(NSDictionary *)data target:(id)target {
	id mappedObject = [data objectForKey:[self key]];

	if (target != nil && mappedObject != nil) {
		[target performSelector:[self action] withObject:mappedObject];
	}
}

@end
