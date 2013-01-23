//
//  IteratingMapper.h
//  Mapplas
//
//  Created by Belén  on 23/01/13.
//  Copyright (c) 2013 Mapplas. All rights reserved.
//

#import "IteratingMapper.h"

@implementation IteratingMapper

@synthesize key = _key, elementMapper = _elementMapper;

- (id)initWithArrayKey:(NSString *)array_key elementMapper:(id<ReturnMapper>)element_mapper {
    self = [super init];
    if (self) {
        _key = array_key;
		_elementMapper = element_mapper;
    }
    return self;
}

- (NSArray *)map:(NSDictionary *)data {
	NSArray *elementJsonArray = [data objectForKey:self.key];
	
	NSMutableArray *resultingArray = [NSMutableArray arrayWithCapacity:[elementJsonArray count]];
	for (NSDictionary *elementJson in elementJsonArray) {
		id mappedElement = [self.elementMapper map:elementJson];
		[resultingArray addObject:mappedElement];
	}
	
	return resultingArray;
}

@end
