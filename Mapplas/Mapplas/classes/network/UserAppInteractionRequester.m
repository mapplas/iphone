//
//  UserAppInteractionRequester.m
//  Mapplas
//
//  Created by Belén  on 01/07/13.
//  Copyright (c) 2013 Mapplas. All rights reserved.
//

#import "UserAppInteractionRequester.h"

@implementation UserAppInteractionRequester

- (void)doRequestWithUserId:(NSNumber *)user_id appId:(NSNumber *)app_id location:(NSString *)location {
    Environment *environment = [Environment sharedInstance];
	AbstractUrlAddresses *urlAdresses = [environment addresses];
    
    connector = [[UserAppInteractionConnector alloc] initWithAddresses:urlAdresses];
    [connector requestWithUserId:user_id appId:app_id location:location];
}

@end
