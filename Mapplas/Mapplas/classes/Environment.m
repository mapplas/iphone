//
//  Environment.h
//  Mapplas
//
//  Created by Belén  on 18/01/13.
//  Copyright (c) 2013 Mapplas. All rights reserved.
//

#import "Environment.h"

static Environment *myInstance = nil;

@implementation Environment

@synthesize addresses = _addresses;
@synthesize appSomethingChangedInDetail = _appSomethingChangedInDetail;

#pragma mark -
#pragma mark Singleton Methods

+ (Environment *)sharedInstance {
	if(!myInstance){
		myInstance = [[Environment hiddenAlloc] init];
	}
	return myInstance;
}

+ (id)hiddenAlloc {
	return [super alloc];
}

+ (BOOL)sharedInstanceExists {
	return (nil != myInstance);
}

+ (id)alloc {
	return [self sharedInstance];
}

+ (id)new {
	return [self alloc];
}


- (id)init {
    if (![[self class] sharedInstanceExists]) {
		[self setAddresses:[[AbstractUrlAddresses alloc] init]];
        [self setAppSomethingChangedInDetail:NO];
	}
	return self;
}

- (void)purge {
}

#pragma mark -
#pragma mark Inicialization Methods		
- (void)awakeFromNib {
	myInstance = self;
}

@end