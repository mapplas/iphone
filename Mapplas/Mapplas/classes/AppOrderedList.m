//
//  AppOrderedList.m
//  Mapplas
//
//  Created by Belén  on 17/01/13.
//  Copyright (c) 2013 Mapplas. All rights reserved.
//

#import "AppOrderedList.h"

@implementation AppOrderedList

@synthesize list = _list;

- (id)init {
    self = [super init];
    if (self) {
        self.list = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)addObject:(App *)app {
    [self.list addObject:app];
}

- (NSUInteger)count {
    return self.list.count;
}

- (App *)objectAtIndex:(NSUInteger)index {
    return [self.list objectAtIndex:index];
}

@end
