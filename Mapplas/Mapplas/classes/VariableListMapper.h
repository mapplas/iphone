//
//  UserIdentificationConnector.m
//  Mapplas
//
//  Created by Belén  on 18/01/13.
//  Copyright (c) 2013 Mapplas. All rights reserved.
//

#import "VariableList.h"
#import "ASIFormDataRequest.h"


@interface VariableListMapper : NSObject

- (void)insert:(VariableList *)variableList into:(ASIFormDataRequest *)request;

@end
