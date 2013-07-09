//
//  AppShareRequest.m
//  Mapplas
//
//  Created by Belén  on 09/05/13.
//  Copyright (c) 2013 Mapplas. All rights reserved.
//

#import "AppShareRequest.h"

@implementation AppShareRequest

- (void)doRequestWithAppId:(NSNumber *)app_id userId:(NSNumber *)user_id andLocation:(NSString *)current_location via:(NSString *)_via {
    Environment *environment = [Environment sharedInstance];
	AbstractUrlAddresses *urlAdresses = [environment addresses];
    
    connector = [[AppShareConnector alloc] initWithAddresses:urlAdresses];
    [connector requestWithAppId:app_id userId:user_id andLocation:current_location via:_via];
}

@end
