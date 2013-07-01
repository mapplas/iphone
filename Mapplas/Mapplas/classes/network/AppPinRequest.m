//
//  AppPinRequest.m
//  Mapplas
//
//  Created by Belén  on 28/01/13.
//  Copyright (c) 2013 Mapplas. All rights reserved.
//

#import "AppPinRequest.h"

@implementation AppPinRequest

- (void)doRequestWithAppId:(NSString *)app_id userId:(NSNumber *)user_id action:(NSString *)_action reverseGeocodedAddress:(NSString *)_address andLocation:(NSString *)current_location {
    Environment *environment = [Environment sharedInstance];
	AbstractUrlAddresses *urlAdresses = [environment addresses];
    
    connector = [[PinConnector alloc] initWithAddresses:urlAdresses];
    [connector requestWithAppId:app_id userId:user_id action:_action reverseGeocodedAddress:_address andLocation:current_location];
}

@end
