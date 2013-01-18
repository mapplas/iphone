//
//  JSONToUserMapper.h
//  Mapplas
//
//  Created by Belén  on 18/01/13.
//  Copyright (c) 2013 Mapplas. All rights reserved.
//

#import "GenericMapper.h"
#import "ReturnMapper.h"
#import "User.h"

@interface JSONToUserMapper : GenericMapper <ReturnMapper>

- (User *)map:(NSDictionary *)json;

@end
