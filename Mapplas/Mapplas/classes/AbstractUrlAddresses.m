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
@synthesize getApps;
@synthesize pinApp;
@synthesize blockApp;
@synthesize rateApp;

- (id)init {
	self = [super init];
	
	if(self) {
        [self setDomain:@"mapplas.com"];
        [self setPort:@"80"];
		[self setRelativePath:@"/Publico"];
        
        [self reloadAddresses];
	}

	return self;
}

- (NSString *)buildAddresWithPath:(NSString *)path {
	return [NSString stringWithFormat:@"http://%@:%@%@%@", [self domain], [self port], [self relativePath], path];
}

- (void)reloadAddresses {
	[self setIdentifyUser:[self buildAddresWithPath:@"/ipc_ii.php"]];
    [self setGetApps:[self buildAddresWithPath:@"/ipc_locations.php"]];
    [self setPinApp:[self buildAddresWithPath:@"/ipc_pin.php"]];
    [self setBlockApp:[self buildAddresWithPath:@"/ipc_like.php"]];
    [self setRateApp:[self buildAddresWithPath:@"/ipc_rate.php"]];
}

@end
