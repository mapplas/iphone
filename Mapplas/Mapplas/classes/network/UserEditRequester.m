//
//  UserEditRequester.m
//  Mapplas
//
//  Created by Belén  on 11/02/13.
//  Copyright (c) 2013 Mapplas. All rights reserved.
//

#import "UserEditRequester.h"

@implementation UserEditRequester

- (void)doRequestWithUser:(User *)_user {
    Environment *environment = [Environment sharedInstance];
	AbstractUrlAddresses *urlAdresses = [environment addresses];
    
    connector = [[UserEditConnector alloc] initWithAddresses:urlAdresses];
    [connector requestWithUser:_user];
}

@end
