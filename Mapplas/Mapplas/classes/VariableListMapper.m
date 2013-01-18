//
//  UserIdentificationConnector.m
//  Mapplas
//
//  Created by Belén  on 18/01/13.
//  Copyright (c) 2013 Mapplas. All rights reserved.
//

#import "VariableListMapper.h"


@implementation VariableListMapper

- (void)insert:(VariableList *)variableList into:(ASIFormDataRequest *)request {
    
	NSEnumerator *variableEnumerator = [variableList objectEnumerator];
	id nextVariable;
    
	while ((nextVariable = [variableEnumerator nextObject]) != NULL) {
        if ([nextVariable isKindOfClass:[VariableText class]]) {
			VariableText *textVariable = nextVariable;
			[request addPostValue:[textVariable textValue] forKey:[textVariable key]];
		}
		else {
			NSLog(@"Warning trying to map an unknown object to an ASIFormDataRequest");
		}
	}
}

@end
