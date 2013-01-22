//
//  UserIdentificationConnector.m
//  Mapplas
//
//  Created by Belén  on 18/01/13.
//  Copyright (c) 2013 Mapplas. All rights reserved.
//

#import "UserIdentificationConnector.h"

@implementation UserIdentificationConnector

- (id)initWithAddresses:(AbstractUrlAddresses *)addresses variableListMapper:(VariableListMapper *)list_mapper responseHandler:(UserIdentificationResponseHandler *)response_handler {
    return [super initWithAddresses:addresses variableListMapper:list_mapper responseHandler:response_handler];
}

- (void)requestWithModel:(SuperModel *)super_model {
    model = super_model;
    
    [parameters addValue:[model currentLocation] withKey:@"l"];
    [parameters addValue:[model currentImei] withKey:@"ii"];
    
    [super initializeVariablesWithUrlAndSend:[self getUrl]];
}

- (NSString *)getUrl {
    return [adresses identifyUser];
}

@end
