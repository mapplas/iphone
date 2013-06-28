//
//  AppBlockRequest.m
//  Mapplas
//
//  Created by Belén  on 28/01/13.
//  Copyright (c) 2013 Mapplas. All rights reserved.
//

#import "AppBlockRequest.h"

@implementation AppBlockRequest

- (void)doRequestWithAppId:(NSString *)app_id userId:(NSNumber *)user_id action:(NSString *)_action {
    Environment *environment = [Environment sharedInstance];
	AbstractUrlAddresses *urlAdresses = [environment addresses];
    
    connector = [[BlockConnector alloc] initWithAddresses:urlAdresses];
    [connector requestWithAppId:app_id userId:user_id action:_action];
}

@end
