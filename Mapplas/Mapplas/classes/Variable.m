//
//  UserIdentificationConnector.m
//  Mapplas
//
//  Created by Belén  on 18/01/13.
//  Copyright (c) 2013 Mapplas. All rights reserved.
//

#import "Variable.h"

@implementation Variable

@synthesize key;
@synthesize correspondingValue;

- (id)initWithValue:(id)var_value forKey:(NSString *)var_key {
	self = [super init];

	if(self) {
		self.key = var_key;
		self.correspondingValue = var_value;
	}

	return self;
}

@end
