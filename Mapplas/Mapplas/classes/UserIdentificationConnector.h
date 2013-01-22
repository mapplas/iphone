//
//  UserIdentificationConnector.h
//  Mapplas
//
//  Created by Belén  on 18/01/13.
//  Copyright (c) 2013 Mapplas. All rights reserved.
//

#import "GenericConnector.h"
#import "SuperModel.h"
#import "ASIFormDataRequest.h"
#import "UserIdentificationResponseHandler.h"

@interface UserIdentificationConnector : GenericConnector {
    SuperModel *model;
}

- (id)initWithAddresses:(AbstractUrlAddresses *)addresses variableListMapper:(VariableListMapper *)list_mapper responseHandler:(UserIdentificationResponseHandler *)response_handler;
- (void)requestWithModel:(SuperModel *)super_model;

@end
