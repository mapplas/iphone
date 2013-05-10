//
//  JSONToPinnedBlockedAppMapper.h
//  Mapplas
//
//  Created by Belén  on 10/05/13.
//  Copyright (c) 2013 Mapplas. All rights reserved.
//

#import "GenericMapper.h"
#import "ReturnMapper.h"
#import "App.h"

#import "KeyValueMapper.h"
#import "KeyValueScappedMapper.h"

@interface JSONToPinnedBlockedAppMapper : GenericMapper <ReturnMapper>

- (App *)map:(NSDictionary *)json;

@end
