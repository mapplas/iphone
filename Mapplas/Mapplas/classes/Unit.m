//
//  Unit.m
//  Mapplas
//
//  Created by Belén  on 12/02/13.
//  Copyright (c) 2013 Mapplas. All rights reserved.
//

#import "Unit.h"

@implementation Unit

@synthesize identifier = _identifier;

- (id)initWithId:(NSString *)key {
    self = [super init];
    if (self) {
        self.identifier = key;
    }
    return self;
}

@end
