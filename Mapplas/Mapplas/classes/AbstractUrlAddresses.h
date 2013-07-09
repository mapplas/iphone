//
//  UserIdentificationConnector.h
//  Mapplas
//
//  Created by Belén  on 18/01/13.
//  Copyright (c) 2013 Mapplas. All rights reserved.
//

@interface AbstractUrlAddresses : NSObject {
	NSString *identifyUser;
}

@property (nonatomic, strong) NSString *domain;
@property (nonatomic, strong) NSString *port;
@property (nonatomic, strong) NSString *relativePath;

@property (nonatomic, strong) NSString *identifyUser;
@property (nonatomic, strong) NSString *editUser;

@property (nonatomic, strong) NSString *getApps;
@property (nonatomic, strong) NSString *pinApp;
@property (nonatomic, strong) NSString *blockApp;
@property (nonatomic, strong) NSString *shareApp;

@property (nonatomic, strong) NSString *appDetail;

@property (nonatomic, strong) NSString *userPinAndBlocks;

@property (nonatomic, strong) NSString *userAppInteraction;

- (void)reloadAddresses;

- (NSString *)getApps:(NSNumber *)apps_multiple;
- (NSString *)userPinAndBlocks:(NSNumber *)user_id;
- (NSString *)appDetail:(NSNumber *)app_id;

@end
