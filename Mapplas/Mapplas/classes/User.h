//
//  User.h
//  Mapplas
//
//  Created by Belén  on 17/01/13.
//  Copyright (c) 2013 Mapplas. All rights reserved.
//

@interface User : NSObject {
    NSNumber *_userId;
    NSString *_tel;
    NSString *_imei;
    NSMutableArray *_pinnedApps;
    NSMutableArray *_blockedApps;
}

- (id)init;

@property (nonatomic, strong) NSNumber *userId;
@property (nonatomic, strong) NSString *tel;
@property (nonatomic, strong) NSString *imei;
@property (nonatomic, strong) NSMutableArray *pinnedApps;
@property (nonatomic, strong) NSMutableArray *blockedApps;

@end
