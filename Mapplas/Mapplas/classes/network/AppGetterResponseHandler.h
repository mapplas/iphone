//
//  AppGetterResponseHandler.h
//  Mapplas
//
//  Created by Belén  on 22/01/13.
//  Copyright (c) 2013 Mapplas. All rights reserved.
//

#import "GenericRequestHandler.h"
#import "NSObject+JSON.h"
#import "JSONToAppMapper.h"
#import "SuperModel.h"
#import "AppTableViewAdapter.h"

@interface AppGetterResponseHandler : NSObject <GenericRequestHandler> {
    SuperModel *model;
    AppTableViewAdapter *adapter;
    UITableView *table;
}

- (id)initWithModel:(SuperModel *)_model tableView:(UITableView *)table_view adapter:(AppTableViewAdapter *)_adapter;

@end
