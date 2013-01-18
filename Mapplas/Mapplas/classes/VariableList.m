//
//  UserIdentificationConnector.m
//  Mapplas
//
//  Created by Belén  on 18/01/13.
//  Copyright (c) 2013 Mapplas. All rights reserved.
//

#import "VariableList.h"


@implementation VariableList

-(id)init{	
	if(self = [super init]){
		variableList = [[NSMutableArray alloc] init];
	}
	return self;
}

#pragma mark -
#pragma mark Adding a text variable

-(void)addValue:(NSString *)value withKey:(NSString *)key{
	VariableText *item = [[VariableText alloc] initWithValue:value forKey:key];
	[variableList addObject:item];
}

#pragma mark -
#pragma mark Array iterator

- (NSEnumerator *)objectEnumerator{
	return [variableList objectEnumerator];
}

@end
