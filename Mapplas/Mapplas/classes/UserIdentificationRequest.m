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
    if (self = [super init]) {
        model = super_model;
    }
    return self;
}

- (void)doRequest {
    connector = [[UserIdentificationConnector alloc] init];
    
    [connector requestWithModel:model];
}

@end
