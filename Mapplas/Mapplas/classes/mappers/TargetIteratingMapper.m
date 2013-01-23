//
//  TargetIteratingMapper.m
//  Mapplas
//
//  Created by Belén  on 23/01/13.
//  Copyright (c) 2013 Mapplas. All rights reserved.
//

#import "TargetIteratingMapper.h"
#import "IteratingMapper.h"

@interface TargetIteratingMapper ()
@property (nonatomic, retain) IteratingMapper *iteratingReturnMapper;
@property (nonatomic, assign) SEL action;

@end

@implementation TargetIteratingMapper
@synthesize iteratingReturnMapper = _iteratingReturnMapper;
@synthesize action = _action;

- (id)initWithArrayKey:(NSString *)array_key elementMapper:(id<ReturnMapper>)element_mapper action:(SEL)action {
    self = [super init];
    if (self) {
        IteratingMapper *iteratingReturnMapper = [[IteratingMapper alloc] initWithArrayKey:array_key elementMapper:element_mapper];
		self.iteratingReturnMapper = iteratingReturnMapper;
		self.action = action;
    }
    return self;
}

- (void)map:(NSDictionary *)data target:(id)target {
	NSArray *mappedArray = [self.iteratingReturnMapper map:data];
	[target performSelector:self.action withObject:mappedArray];
}

@end
