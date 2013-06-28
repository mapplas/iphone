//
//  TargetIteratingMapper.h
//  Mapplas
//
//  Created by Belén  on 23/01/13.
//  Copyright (c) 2013 Mapplas. All rights reserved.
//

#import "TargetMapper.h"
#import "ReturnMapper.h"


@interface TargetIteratingMapper : NSObject<TargetMapper>

- (id)initWithArrayKey:(NSString *)array_key elementMapper:(id<ReturnMapper>)element_mapper action:(SEL)action;

@end
