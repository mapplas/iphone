//
//  JSONToUserMapper.m
//  Mapplas
//
//  Created by Belén  on 18/01/13.
//  Copyright (c) 2013 Mapplas. All rights reserved.
//

#import "TargetMapper.h"

@interface GenericMapper : NSObject {
	@private
	NSArray *mappers;
}

- (id)initWithMappers:(NSArray *)inPropertiesToMap;
- (void)map:(NSDictionary *)json target:(id)target;

@end
