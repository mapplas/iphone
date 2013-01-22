//
//  UserIdentificationRequest.m
//  Mapplas
//
//  Created by Belén  on 18/01/13.
//  Copyright (c) 2013 Mapplas. All rights reserved.
//

#import "UserIdentificationRequest.h"

@implementation UserIdentificationRequest

- (id)initWithSuperModel:(SuperModel *)super_model {
    self = [super init];
    if (self) {
        model = super_model;
    }
    return self;
}

- (void)doRequest {
    Environment *environment = [Environment sharedInstance];
	
	AbstractUrlAddresses *urlAdresses = [environment addresses];
    UserIdentificationResponseHandler *handler = [[UserIdentificationResponseHandler alloc] initWithSuperModel:model];
    
    connector = [[UserIdentificationConnector alloc] initWithAddresses:urlAdresses responseHandler:handler];
    [connector requestWithModel:model];
}

@end
