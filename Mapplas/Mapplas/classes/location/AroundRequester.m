//
//  AroundRequester.m
//  Mapplas
//
//  Created by Belén  on 18/01/13.
//  Copyright (c) 2013 Mapplas. All rights reserved.
//

#import "AroundRequester.h"

@implementation AroundRequester

- (id)initWithLocationManager:(LocationManager *)location_manager model:(SuperModel *)s_model table:(UITableView *)_table tableAdapter:(AppTableViewAdapter *)table_adapter {
    self = [super init];
    if (self) {
        locationManager = location_manager;
        model = s_model;
        appTable = _table;
        adapter = table_adapter;
        [locationManager setListener:self];
    }
    return self;
}

- (void)startRequesting {
    [locationManager startLocationNotifications];
}

- (void)stop {
    [locationManager stopLocationNotifications];
}

#pragma mark - Location listener methods

- (void)locationFound:(CLLocation *)location {    
    Environment *environment = [Environment sharedInstance];
	
	AbstractUrlAddresses *urlAdresses = [environment addresses];
    handler = [[AppGetterResponseHandler alloc] initWithModel:model tableView:appTable adapter:adapter];

    connector = [[AppGetterConnector alloc] initWithAddresses:urlAdresses responseHandler:handler];
    [connector requestWithModel:model andLocation:location];
}

- (void)locationSearchDidTimeout {
    // SHOW TOAST
    NSLog(@"LOCATION DID TIMEOUT!!");
}

@end