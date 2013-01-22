//
//  NotificationList.m
//  Mapplas
//
//  Created by Belén  on 17/01/13.
//  Copyright (c) 2013 Mapplas. All rights reserved.
//

#import "NotificationList.h"

@implementation NotificationList

@synthesize list = _list;

- (id)init {
    self = [super init];
    if (self) {
        self.list = [[NSMutableArray alloc] init];
    }
    return self;
}

@end
