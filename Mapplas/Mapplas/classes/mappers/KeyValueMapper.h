//
//  JSONToUserMapper.m
//  Mapplas
//
//  Created by Belén  on 18/01/13.
//  Copyright (c) 2013 Mapplas. All rights reserved.
//

#import "TargetMapper.h"

@interface KeyValueMapper : NSObject <TargetMapper> {
	NSString *_key;
	SEL _action;
}

@property (nonatomic, readonly) NSString *key;
@property (nonatomic, readonly) SEL action;

- (id)initWithKey:(NSString *)key action:(SEL)action;

@end
