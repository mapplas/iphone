//
//  UserIdentificationConnector.m
//  Mapplas
//
//  Created by Belén  on 18/01/13.
//  Copyright (c) 2013 Mapplas. All rights reserved.
//

#import "VariableText.h"

@interface VariableList : NSObject {
	NSMutableArray *variableList;    
}

-(void)addValue:(NSString *)value withKey:(NSString *)key;
- (NSEnumerator *)objectEnumerator;

@end
