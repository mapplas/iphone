//
//  UserIdentificationConnector.h
//  Mapplas
//
//  Created by Belén  on 18/01/13.
//  Copyright (c) 2013 Mapplas. All rights reserved.
//

#import "AbstractUrlAddresses.h"

@implementation AbstractUrlAddresses

@synthesize identifyUser;

@synthesize domain;
@synthesize port;
@synthesize relativePath;

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
}

@end
