//
//  User.m
//  Mapplas
//
//  Created by Belén  on 17/01/13.
//  Copyright (c) 2013 Mapplas. All rights reserved.
//

#import "User.h"

@implementation User

@synthesize userId = _userId;
@synthesize tel = _tel;
@synthesize imei = _imei;
@synthesize pinnedApps = _pinnedApps;
@synthesize blockedApps = _blockedApps;

- (id)init {
    self = [super init];
    if (self) {
        self.userId = [NSNumber numberWithInt:0];
        self.imei = @"";
        self.tel = @"iPhone";
        self.pinnedApps = [[NSMutableArray alloc] init];
        self.blockedApps = [[NSMutableArray alloc] init];
    }
    return self;
}

@end
