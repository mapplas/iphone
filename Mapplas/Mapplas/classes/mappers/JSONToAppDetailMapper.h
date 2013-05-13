//
//  JSONToAppDetailMapper.h
//  Mapplas
//
//  Created by Belén  on 13/05/13.
//  Copyright (c) 2013 Mapplas. All rights reserved.
//

#import "GenericMapper.h"
#import "TargetMapper.h"
#import "App.h"

#import "KeyValueMapper.h"
#import "KeyValueScappedMapper.h"
#import "JSONToPhotoMapper.h"
#import "TargetIteratingMapper.h"

@interface JSONToAppDetailMapper : GenericMapper <TargetMapper>

- (void)map:(NSDictionary *)data app:(App *)app;

@end

