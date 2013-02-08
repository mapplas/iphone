//
//  UserPinUpsRequester.m
//  Mapplas
//
//  Created by Belén  on 08/02/13.
//  Copyright (c) 2013 Mapplas. All rights reserved.
//

#import "UserPinUpsRequester.h"

@implementation UserPinUpsRequester

- (void)doRequestWithUser:(User *)_user table:(UITableView *)_table {
    Environment *environment = [Environment sharedInstance];
	AbstractUrlAddresses *urlAdresses = [environment addresses];
    JSONToAppMapper *appMapper = [[JSONToAppMapper alloc] init];
    UserPinUpsResponseHandler *handler = [[UserPinUpsResponseHandler alloc] initWithAppMapper:appMapper user:_user table:_table];
    
    connector = [[UserPinUpsConnector alloc] initWithAddresses:urlAdresses responseHandler:handler];
    [connector requestWithUser:_user];
}

@end
