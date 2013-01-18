//
//  UserIdentificationConnector.m
//  Mapplas
//
//  Created by Belén  on 18/01/13.
//  Copyright (c) 2013 Mapplas. All rights reserved.
//

#import "VariableText.h"

@implementation VariableText

- (id)initWithValue:(NSString *)init_value forKey:(NSString *)for_key {
	return [super initWithValue:init_value forKey:for_key];
}

- (NSString *)textValue {
	return (NSString *)[super correspondingValue];
}

@end
