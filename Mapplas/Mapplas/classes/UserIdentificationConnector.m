//
//  UserIdentificationConnector.m
//  Mapplas
//
//  Created by Belén  on 18/01/13.
//  Copyright (c) 2013 Mapplas. All rights reserved.
//

#import "UserIdentificationConnector.h"

@implementation UserIdentificationConnector

- (id)initWithAddresses:(AbstractUrlAddresses *)addresses responseHandler:(UserIdentificationResponseHandler *)response_handler {
    return [super initWithAddresses:addresses responseHandler:response_handler];
}

- (void)requestWithModel:(SuperModel *)super_model {
    model = super_model;
    
//    [parameters setValue:[model currentLocation] forKey:@"l"];
    [parameters setValue:[model currentImei] forKey:@"ii"];
    
    [super initializeVariablesWithUrlAndSend:[self getUrl]];
}

- (NSString *)getUrl {
    return [adresses identifyUser];
}

@end
