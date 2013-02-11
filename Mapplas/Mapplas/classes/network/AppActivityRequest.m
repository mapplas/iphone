//
//  AppActivityRequest.m
//  Mapplas
//
//  Created by Belén  on 11/02/13.
//  Copyright (c) 2013 Mapplas. All rights reserved.
//

#import "AppActivityRequest.h"

@implementation AppActivityRequest

- (void)doRequestWithLocation:(NSString *)location action:(NSString *)action app:(App *)app andUser:(User *)user {
    Environment *environment = [Environment sharedInstance];
	AbstractUrlAddresses *urlAdresses = [environment addresses];
    
    connector = [[ActivityConnector alloc] initWithAddresses:urlAdresses];
    [connector requestWithCurrentLocation:location action:action app:app andUser:user];
}

@end
