//
//  UserIdentificationConnector.h
//  Mapplas
//
//  Created by Belén  on 18/01/13.
//  Copyright (c) 2013 Mapplas. All rights reserved.
//

#import "SuperModel.h"
#import "AbstractUrlAddresses.h"
#import "VariableList.h"
#import "VariableListMapper.h"
#import "ASIFormDataRequest.h"
#import "UserIdentificationResponseHandler.h"

@interface UserIdentificationConnector : NSObject {
    ASIFormDataRequest *_request;
    
    AbstractUrlAddresses *adresses;
    VariableListMapper *variableListMapper;
    UserIdentificationResponseHandler *handler;

    SuperModel *model;
}

@property (nonatomic, strong) ASIFormDataRequest *request;

- (id)initWithAddresses:(AbstractUrlAddresses *)_addresses variableListMapper:(VariableListMapper *)list_mapper responseHandler:(UserIdentificationResponseHandler *)response_handler;

- (void)requestWithModel:(SuperModel *)super_model;

@end
