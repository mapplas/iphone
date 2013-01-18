//
//  JSONToUserMapper.m
//  Mapplas
//
//  Created by Belén  on 18/01/13.
//  Copyright (c) 2013 Mapplas. All rights reserved.
//

@protocol ReturnMapper <NSObject>

@optional
- (id)map:(NSDictionary *)data;
- (id)map:(NSDictionary *)data andSetString:(NSString *)string_to_set;

@end
