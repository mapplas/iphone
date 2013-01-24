//
//  IteratingMapper.h
//  Mapplas
//
//  Created by Belén  on 23/01/13.
//  Copyright (c) 2013 Mapplas. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TargetMapper.h"
#import "ReturnMapper.h"

@interface IteratingMapper : NSObject <ReturnMapper> {
	NSString *_key;
	id<ReturnMapper> _elementMapper;
}

@property (nonatomic, readonly) NSString *key;
@property (nonatomic, readonly) id<ReturnMapper> elementMapper;

- (id)initWithArrayKey:(NSString *)array_key elementMapper:(id<ReturnMapper>)element_mapper;
- (NSArray *)map:(NSDictionary *)data;

@end
