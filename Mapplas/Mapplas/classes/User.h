//
//  User.h
//  Mapplas
//
//  Created by Belén  on 17/01/13.
//  Copyright (c) 2013 Mapplas. All rights reserved.
//

@interface User : NSObject {
    NSNumber *_userId;
    NSString *_name;
    NSString *_lastName;
    NSString *_gender;
    NSString *_birthdate;
    NSString *_login;
    NSString *_password;
    NSString *_email;
    NSString *_imei;
    NSMutableArray *_pinnedApps;
    NSMutableArray *_blockedApps;
}

- (id)init;

@property (nonatomic, strong) NSNumber *userId;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *lastName;
@property (nonatomic, strong) NSString *gender;
@property (nonatomic, strong) NSString *birthdate;
@property (nonatomic, strong) NSString *login;
@property (nonatomic, strong) NSString *password;
@property (nonatomic, strong) NSString *email;
@property (nonatomic, strong) NSString *imei;
@property (nonatomic, strong) NSMutableArray *pinnedApps;
@property (nonatomic, strong) NSMutableArray *blockedApps;

@end
