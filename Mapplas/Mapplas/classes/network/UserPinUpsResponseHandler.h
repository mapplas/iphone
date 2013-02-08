//
//  UserPinUpsResponseHandler.h
//  Mapplas
//
//  Created by Belén  on 08/02/13.
//  Copyright (c) 2013 Mapplas. All rights reserved.
//

#import "GenericRequestHandler.h"
#import "JSONToAppMapper.h"
#import "User.h"

@interface UserPinUpsResponseHandler : NSObject <GenericRequestHandler> {
    JSONToAppMapper *appMapper;
    User *user;
    UITableView *table;
}

- (id)initWithAppMapper:(JSONToAppMapper *)app_mapper user:(User *)_user table:(UITableView *)_table;

@end
