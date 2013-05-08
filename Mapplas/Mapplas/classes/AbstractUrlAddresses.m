//
//  UserIdentificationConnector.h
//  Mapplas
//
//  Created by Belén  on 18/01/13.
//  Copyright (c) 2013 Mapplas. All rights reserved.
//

#import "AbstractUrlAddresses.h"

@implementation AbstractUrlAddresses

@synthesize domain;
@synthesize port;
@synthesize relativePath;

@synthesize activity;

@synthesize identifyUser;
@synthesize editUser;

@synthesize getApps;
@synthesize pinApp;
@synthesize blockApp;
@synthesize rateApp;

@synthesize userPinUps;
@synthesize userBlocks;

- (id)init {
	self = [super init];
	
	if(self) {
//        Old domain
//        [self setDomain:@"h1975711.stratoserver.net"];
        [self setDomain:@"54.217.243.16"];
        [self setPort:@"80"];
		[self setRelativePath:@"/api"];
        
        [self reloadAddresses];
	}

	return self;
}

- (NSString *)buildAddresWithPath:(NSString *)path {
	return [NSString stringWithFormat:@"http://%@:%@%@%@", [self domain], [self port], [self relativePath], path];
}

- (void)reloadAddresses {
    [self setActivity:[self buildAddresWithPath:@"/ipc_activity.php"]];
    
	[self setIdentifyUser:[self buildAddresWithPath:@"/user/add"]];
    [self setEditUser:[self buildAddresWithPath:@"/ipc_userEdit.php"]];
    
    [self setGetApps:[self buildAddresWithPath:@"/apps"]];
    [self setPinApp:[self buildAddresWithPath:@"/ipc_pin.php"]];
    [self setBlockApp:[self buildAddresWithPath:@"/ipc_like.php"]];
    [self setRateApp:[self buildAddresWithPath:@"/ipc_rate.php"]];
    
    [self setUserPinUps:[self buildAddresWithPath:@"/ipc_userPinups.php"]];
    [self setUserBlocks:[self buildAddresWithPath:@"/ipc_userBlocks.php"]];
}

@end
