//
//  AppShareRequest.m
//  Mapplas
//
//  Created by Belén  on 09/05/13.
//  Copyright (c) 2013 Mapplas. All rights reserved.
//

#import "AppShareRequest.h"

@implementation AppShareRequest

- (void)doRequestWithAppId:(NSString *)app_id userId:(NSNumber *)user_id andLocation:(NSString *)current_location {
    Environment *environment = [Environment sharedInstance];
	AbstractUrlAddresses *urlAdresses = [environment addresses];
    
    connector = [[AppShareConnector alloc] initWithAddresses:urlAdresses];
    [connector requestWithAppId:app_id userId:user_id andLocation:current_location];
}

@end
