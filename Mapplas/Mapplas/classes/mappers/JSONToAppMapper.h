//
//  JSONToAppMapper.h
//  Mapplas
//
//  Created by Belén  on 23/01/13.
//  Copyright (c) 2013 Mapplas. All rights reserved.
//

#import "GenericMapper.h"
#import "ReturnMapper.h"
#import "App.h"
#import "KeyValueMapper.h"
#import "KeyValueScappedMapper.h"
#import "TargetIteratingMapper.h"
#import "JSONToCommentMapper.h"
#import "JSONToPhotoMapper.h"

@interface JSONToAppMapper : GenericMapper <ReturnMapper>

- (App *)map:(NSDictionary *)json;

@end
