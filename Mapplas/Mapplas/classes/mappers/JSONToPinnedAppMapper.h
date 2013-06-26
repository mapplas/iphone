//
//  JSONToPinnedAppMapper.h
//  Mapplas
//
//  Created by Belén  on 26/06/13.
//  Copyright (c) 2013 Mapplas. All rights reserved.
//

#import "GenericMapper.h"
#import "ReturnMapper.h"
#import "App.h"

#import "KeyValueMapper.h"
#import "KeyValueScappedMapper.h"

@interface JSONToPinnedAppMapper : GenericMapper <ReturnMapper>

- (App *)map:(NSDictionary *)json;

@end
