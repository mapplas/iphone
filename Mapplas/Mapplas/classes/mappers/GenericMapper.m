//
//  JSONToUserMapper.m
//  Mapplas
//
//  Created by Belén  on 18/01/13.
//  Copyright (c) 2013 Mapplas. All rights reserved.
//

#import "GenericMapper.h"

@implementation GenericMapper

- (id)initWithMappers:(NSArray *)inMappers  {
    self = [super init];

    if (self) {
        mappers = inMappers;
    }

    return self;
}

- (void)map:(NSDictionary *)json target:(id)target {
	for (id<TargetMapper> targetMapper in mappers) {
		[targetMapper map:json target:target];
	}
}

@end
