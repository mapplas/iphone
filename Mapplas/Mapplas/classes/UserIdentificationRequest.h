//
//  UserIdentificationRequest.h
//  Mapplas
//
//  Created by Belén  on 18/01/13.
//  Copyright (c) 2013 Mapplas. All rights reserved.
//

#import "SuperModel.h"
#import "UserIdentificationConnector.h"
#import "Environment.h"

@class AppsViewController;

@interface UserIdentificationRequest : NSObject {
    SuperModel *model;
    UserIdentificationConnector *connector;
    AppsViewController *viewController;
}

- (id)initWithSuperModel:(SuperModel *)super_model andViewController:(AppsViewController *)view_controller;
- (void)doRequest;

@end
