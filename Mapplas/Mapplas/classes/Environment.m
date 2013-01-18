//
//  Environment.m
//  Quomai
//
//  Created by Fran Naranjo on 03/03/11.
//  Copyright 2011 Quomai. All rights reserved.
//

#import "Environment.h"

static Environment *myInstance = nil;

@implementation Environment

@synthesize addresses;


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