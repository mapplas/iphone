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

@synthesize identifyUser;
@synthesize editUser;

@synthesize getApps;

@synthesize pinApp;
@synthesize blockApp;
@synthesize shareApp;

@synthesize appDetail;

@synthesize userPinAndBlocks;

@synthesize userAppInteraction;

- (id)init {
	self = [super init];
	
	if(self) {
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
	[self setIdentifyUser:[self buildAddresWithPath:@"/user/add"]];
    
    [self setPinApp:[self buildAddresWithPath:@"/user/pin"]];
    [self setBlockApp:[self buildAddresWithPath:@"/user/block"]];
    [self setShareApp:[self buildAddresWithPath:@"/user/share"]];
}

- (NSString *)getApps:(NSNumber *)apps_multiple {
    return [self buildAddresWithPath:[NSString stringWithFormat:@"/apps/%d", [apps_multiple integerValue]]];
}

- (NSString *)userPinAndBlocks:(NSNumber *)user_id {
    return [self buildAddresWithPath:[NSString stringWithFormat:@"/user-apps-info/%d", [user_id integerValue]]];
}

- (NSString *)appDetail:(NSString *)app_id {
    return [self buildAddresWithPath:[NSString stringWithFormat:@"/app-detail/%@", app_id]];
}

- (NSString *)userAppInteraction {
    return [self buildAddresWithPath:[NSString stringWithFormat:@"/user/app-interaction"]];
}

@end
