//
//  AroundRequester.h
//  Mapplas
//
//  Created by Belén  on 18/01/13.
//  Copyright (c) 2013 Mapplas. All rights reserved.
//

#import "LocationListener.h"
#import "LocationManager.h"
#import "AppGetterConnector.h"
#import "Environment.h"
#import "AppTableViewAdapter.h"

@interface AroundRequester : NSObject <LocationListener> {
	LocationManager *locationManager;
    SuperModel *model;
    AppGetterConnector *connector;
    AppGetterResponseHandler *handler;
    AppTableViewAdapter *adapter;
    
    UITableView *appTable;
}

- (id)initWithLocationManager:(LocationManager *)location_manager model:(SuperModel *)s_model table:(UITableView *)_table tableAdapter:(AppTableViewAdapter *)table_adapter;

- (void)startRequesting;
- (void)stop;

@end


