//
//  JSONToUserMapper.m
//  Mapplas
//
//  Created by Belén  on 18/01/13.
//  Copyright (c) 2013 Mapplas. All rights reserved.
//

@protocol TargetMapper <NSObject>

@required
- (void)map:(NSDictionary *)data target:(id)target;

@end
