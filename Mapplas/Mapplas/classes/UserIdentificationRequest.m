//
//  UserIdentificationRequest.m
//  Mapplas
//
//  Created by Belén  on 18/01/13.
//  Copyright (c) 2013 Mapplas. All rights reserved.
//

#import "UserIdentificationRequest.h"
#import "AppsViewController.h"

@implementation UserIdentificationRequest

- (id)initWithSuperModel:(SuperModel *)super_model andViewController:(AppsViewController *)view_controller {
    self = [super init];
    if (self) {
        model = super_model;
        viewController = view_controller;
    }
    return self;
}

- (void)doRequest {
    Environment *environment = [Environment sharedInstance];
	
	AbstractUrlAddresses *urlAdresses = [environment addresses];
    UserIdentificationResponseHandler *handler = [[UserIdentificationResponseHandler alloc] initWithSuperModel:model andViewController:viewController];
    
    connector = [[UserIdentificationConnector alloc] initWithAddresses:urlAdresses responseHandler:handler];
    [connector requestWithModel:model];
}

@end
