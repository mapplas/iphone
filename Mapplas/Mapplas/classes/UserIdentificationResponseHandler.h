//
//  UserIdentificationResponseHandler.h
//  Mapplas
//
//  Created by Belén  on 18/01/13.
//  Copyright (c) 2013 Mapplas. All rights reserved.
//

#import "GenericRequestHandler.h"
#import "SuperModel.h"

@class AppsViewController;

@interface UserIdentificationResponseHandler : NSObject <GenericRequestHandler> {
    SuperModel *model;
    AppsViewController *viewController;
}

- (id)initWithSuperModel:(SuperModel *)_model andViewController:(AppsViewController *)view_controller;

@end
