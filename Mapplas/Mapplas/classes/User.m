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
@synthesize name = _name;
@synthesize lastName = _lastName;
@synthesize gender = _gender;
@synthesize birthdate = _birthdate;
@synthesize login = _login;
@synthesize password = _password;
@synthesize email = _email;
@synthesize imei = _imei;
@synthesize pinnedApps = _pinnedApps;
@synthesize blockedApps = _blockedApps;

- (id)init {
    if (self = [super init]) {
        self.userId = @"0";
        self.name = @"";
        self.lastName = @"";
        self.gender = @"";
        self.birthdate = @"";
        self.login = @"";
        self.password = @"";
        self.email = @"";
        self.imei = @"";
        self.pinnedApps = [[NSMutableArray alloc] init];
        self.blockedApps = [[NSMutableArray alloc] init];
    }
    return self;
}

@end
