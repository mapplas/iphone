//
//  JSONToPhotoMapper.h
//  Mapplas
//
//  Created by Belén  on 23/01/13.
//  Copyright (c) 2013 Mapplas. All rights reserved.
//

#import "GenericMapper.h"
#import "ReturnMapper.h"
#import "KeyValueMapper.h"
#import "KeyValueScappedMapper.h"
#import "Photo.h"

@interface JSONToPhotoMapper : GenericMapper <ReturnMapper>

- (Photo *)map:(NSDictionary *)data;

@end
